#pip install pyserial

import tkinter as tk
from tkinter import ttk, scrolledtext
import serial.tools.list_ports
import threading
from functools import partial
import binascii

SEND = 3 #송신 메시지 창의 개수
INIT_TEXT = [ #송신 메시지 창의 초기값
    ("00", "10203040 50607080"),
    ("02", "01020304 05060708"),
    ("03", "83D8AFEF 97D1D369")]
class UartApp:
    def __init__(self, root):

        # tkinter 생성
        self.root = root
        self.root.title("UART 통신 프로그램")
        self.root.geometry("460x605")    # 창 크기        

        # 변수 초기화
        self.hex_check = [] # 16진수 표기 체크 박스에 연결되는 변수
        for i in range(SEND):
            self.hex_check.append(tk.BooleanVar())
            self.hex_check[-1].set(True)

        self.text = [] # 송수신 메시지를 위한 텍스트(마지막(-1): 수신, 나머지(0~): 송신)
        self.send_button = []  # 송신 버튼
        self.hex_checkbox = []  # 16진수 표기 체크 박스
        self.isRx = False
        self.serial_port = serial.Serial()
        
        # GUI 요소 생성
        self.create_widgets()

    def create_widgets(self):  
        # Baud rate 선택 메뉴
        baud_rates = [9600, 115200]  # 사용 가능한 Baud rate 목록
        self.baud_rate_var = tk.StringVar()
        self.baud_rate_var.set(baud_rates[-1])
        self.baud_rate_menu = ttk.Combobox(self.root, textvariable=self.baud_rate_var, values=baud_rates, width = 19)
        self.baud_rate_menu.grid(row=0, column=1, padx = 5, pady = 5)

        # 포트 선택 메뉴
        ports = self.get_available_ports()
        self.port_var = tk.StringVar()
        self.port_var.set(ports[-1])
        self.port_menu = ttk.Combobox(self.root, textvariable=self.port_var, values=ports, width = 18)
        self.port_menu.grid(row=0, column=2)   

        # 연결 버튼
        self.connect_button = tk.Button(self.root, text="      연결      ", command=self.connect_serial)
        self.connect_button.grid(row=0, column=3, columnspan = 2)

        for i in range(SEND):
            # 송신 텍스트 입력 상자
            self.text.append(tk.Entry(self.root, width=5))
            self.text.append(tk.Entry(self.root, width=45))
            self.text[-2].grid(row=i+1, column=0, padx = 5)
            self.text[-1].grid(row=i+1, column=1, columnspan=2)
            self.text[-2].insert(tk.END, INIT_TEXT[i][0])
            self.text[-1].insert(tk.END, INIT_TEXT[i][1])

            # 체크 박스        
            self.hex_checkbox.append(ttk.Checkbutton(self.root, text="Hex", variable=self.hex_check[i], command=partial(self.toggle_hex_display, i)))
            self.hex_checkbox[-1].grid(row=i+1, column=3)

            # 전송 버튼
            self.send_button.append(tk.Button(self.root, text="전송", command=partial(self.send_data, i)))
            self.send_button[-1].grid(row=i+1, column=4)

        # 송수신 등의 메시지 스크롤 상자
        self.output_scroll = scrolledtext.ScrolledText(self.root, width=61, height=35)
        self.output_scroll.grid(row=SEND+2, column=0, columnspan=5, padx = 5, pady = 5)
        self.output_scroll.tag_config("Tx", foreground = 'red') # 색 설정: 송신
        self.output_scroll.tag_config("Rx", foreground = 'blue') # 색 설정: 수신
        self.output_scroll.tag_config("Cmd", foreground = 'green') # 색 설정: 설정 메시지

        # 수신 데이터 출력 상자
        self.text.append(tk.Entry(self.root, width=57))
        self.text[-1].grid(row=SEND+3, column=0, columnspan=4, padx = 5)    

        # 수신 체크 박스        
        self.hex_checkbox.append(ttk.Checkbutton(self.root, text="Hex", variable=self.hex_check[-1], command=partial(self.toggle_hex_display, -1)))
        self.hex_checkbox[-1].grid(row=SEND+3, column=4)        
        
    def get_available_ports(self):  # 사용 가능한 시리얼 포트 목록 가져오기        
        return [port.device for port in serial.tools.list_ports.comports()]

    def connect_serial(self): # 시리얼 포트 연결
        if not self.serial_port.is_open: # 이미 열려 있지 않을 때
            try:
                selected_port = self.port_var.get()
                if selected_port:
                    self.serial_port.port = selected_port # 포트 설정
                    self.serial_port.baudrate = int(self.baud_rate_var.get()) # baudrate 설정
                    self.serial_port.open() # 포트 열기
                    self.add_scroll("시리얼 포트 연결 성공\n", "Cmd")

                    # 시리얼 데이터 수신을 위한 쓰레드 시작
                    self.receive_thread = threading.Thread(target=self.receive_data)
                    self.receive_thread.start()

                else: self.add_scroll("포트를 선택하세요.\n", "Cmd")
            except Exception as e: self.add_scroll(f"시리얼 포트 연결 실패: {str(e)}\n", "Cmd")
        else: self.add_scroll("이미 연결되어 있습니다.\n", "Cmd")
        self.output_scroll.yview(tk.END) # 창 맨 아래로

    def send_data(self, i): # 텍스트 입력 상자의 내용을 시리얼로 전송
        if self.serial_port.is_open:  # 포트가 열려 있을 때
            text = self.text[i*2].get()+self.text[i*2+1].get() # 송신 텍스트 읽어오기

            # 16진수로 변환
            if self.hex_check[i].get(): hex_data = self.align_hex(text)                            
            else: hex_data = self.convert_to_hex(text)

            # 송신 메시지 추가
            self.add_scroll(hex_data+'\n', "Tx")
            
            # 데이터 송신
            self.serial_port.write(binascii.unhexlify(hex_data.replace(" ", "")))
        else: self.add_scroll("연결되어 있지 않습니다.\n", "Cmd")

    def receive_data(self): # 시리얼로부터 데이터를 읽고 출력창에 표시        
        while self.serial_port.is_open:
            try:
                # 수신 데이터 읽기
                rx_text = ""
                rx_hex_text = ""
                for c in self.serial_port.read():
                    rx_text += chr(c)
                    rx_hex_text = "%02X " % c
                self.isRx = True                

                # 수신 메시지 추가
                self.add_scroll(rx_hex_text, "Rx")
                if self.hex_check[-1].get(): self.text[-1].insert(tk.END, rx_hex_text)
                else: self.text[-1].insert(tk.END, rx_text)                
            except Exception as e: self.output_scroll.insert(tk.END, f"수신 오류: {str(e)}\n", "Cmd")
            self.output_scroll.yview(tk.END)  # 창 맨 아래로           

    def align_hex(self, hex_text): # 16진수 각 두 글자마다 공백 넣어 정렬
        hex_text = hex_text.replace(" ", "")
        new_text = ""
        for i in range(0, len(hex_text), 2):
            new_text += hex_text[i:i+2] + " "
        return new_text[:-1]
        
    def convert_from_hex(self, hex_text): # 16진수를 원래 문자로 변환                
        hex_text = hex_text.split()        
        try:
            text = [chr(int(value, 16)) for value in hex_text]            
            return ''.join(text)
        except ValueError as e: return f"변환 오류: {str(e)}"
        
    def convert_to_hex(self, text, i = 6): # 텍스트를 16진수로 변환
        if text: hex_text = ' '.join(format(ord(char), '02X') for char in text)
        elif i in [0, 2, 4]: hex_text = "00" #데이터가 0x00에 해당하는 경우의 예외 처리
        else: hex_text = ""
        return hex_text
    
    def toggle_hex_display(self, i):        # 체크 박스 상태에 따라 텍스트 입력 상자의 내용 변환        
        if i != -1: # 송신 텍스트창
            self.each_toggle_hex_display(i*2  , i)
            self.each_toggle_hex_display(i*2+1, i)
        else: # 수신 텍스트창
            self.each_toggle_hex_display(i, i)

    def each_toggle_hex_display(self, i, j):
        # 텍스트 읽어오기
        text = self.text[i].get()

        # 진수 변환
        if self.hex_check[j].get(): text = self.convert_to_hex(text, i)
        else                      : text = self.convert_from_hex(self.align_hex(text))

        # 텍스트 상자에 표기
        self.text[i].delete(0, tk.END)
        self.text[i].insert(0, text)

    def add_scroll(self, text, color):
        if color != "Rx" and self.isRx:
            self.output_scroll.insert(tk.END, '\n', "Tx")
            self.text[-1].delete(0, tk.END)
            self.isRx = False
        self.output_scroll.insert(tk.END, text, color)
        self.output_scroll.yview(tk.END) # 창 맨 아래로

if __name__ == "__main__":
    root = tk.Tk()
    app = UartApp(root)
    root.mainloop()
