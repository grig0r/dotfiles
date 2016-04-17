#!/usr/bin/python -u
# coding=UTF-8

from signal import signal,SIGPIPE,SIG_DFL
signal(SIGPIPE,SIG_DFL)
import os
import subprocess
import re
import time

space = " "
def_font = "^fn()"
font_awesome = "^fn(FontAwesome-10)"
def_fg = "^fg()"
grey_fg = "^fg(#777777)"
symbol_font = font_awesome + grey_fg
default = def_font + def_fg
def_link="^ca()"
sep=def_font + " ^fg(#777777)| "
round_number = 2
    
while True:

    def clock( input = subprocess.check_output(["date"], universal_newlines=True) ):
            # print("input: ", input)
        h_m = re.sub(r'.*[\s]+(\d*):(\d*):(\d*).*\n+',
                r'\1:\2',
                input)
        date = re.sub(r'^(\w*)[\s]+(\w*)[\s]+(\w*).*\n+',
                r'\1 \3 \2',
                input)
        output = default + date + space + h_m
        return output

    def brightness(input=subprocess.check_output(["light"], universal_newlines=True)):
        blight = re.sub(r'(\d)\..*\n+',
                r'\1%',
                input)
        symbol = ""
        output = symbol_font + symbol + default + space + blight
        return output

    def volume(input=subprocess.check_output(["amixer", "get", "Master", "-M"], universal_newlines=True), link="^ca(1,pavucontrol > /dev/null)"):
        vol = re.sub(r'\n',
                r'',
                input)
        vol = re.sub(r'.*\[(\d+[%])\].*',
                r'\1',
                vol)
        # check = re.sub(r'[\S\s]*\[(\w+)\]\n$', r'\1',
        check = re.sub(r'[\s\S]*\[(\w+)\]\n$',
                r'\1',
                input)
        if check in 'on':
            symbol = ""
            main_font = default
        elif check in "off":
            symbol = "  "
            main_font = grey_fg + def_font
        output = link + symbol_font + symbol + main_font + space + vol + def_link
        return output

    # def mpd_main(check=os.system("mpc")):
    def mpd_check(check=os.system("mpc > /dev/null")):
        if not check == 0:
            return False
        input=subprocess.check_output(["mpc"], universal_newlines=True)
        status = re.sub(r'([\s\S]*\[)(\w+)(\][\s\S]*)',
                r'\2',
                input)
        # print(status)
        if status in ('playing', 'paused'):
            return status
            # print("true")
        else:
            return False
            # print("false")

    def mpd(link="^ca(1,urxvt -e ncmpcpp)"):
        # link="^ca(1,urxvt -e ncmpcpp)"
        input=subprocess.check_output(["mpc"], universal_newlines=True)

        song = re.sub(r'(.*)(\n)(.*)(\n)(.*\n)',
                    r'\1',
                    input)
        prog = re.sub(r'(.*\n).*[\s]+([0-9:/]*)[\s]+(.*\n){2}',
                    r'\2',
                    input)
        symbol = ""
        mpd_output = link + symbol_font + symbol + default + space + song[:40] + space + prog + def_link
        return mpd_output

    def mpd_controls(status=mpd_check()):
        prev = "^ca(1,mpc prev)^ca()  "
        stop = "^ca(1,mpc stop)^ca()  "
        if status in 'playing':
            play_pause = "^ca(1,mpc toggle)^ca()  "
        elif status in 'paused':
            play_pause = "^ca(1,mpc toggle)^ca()  "
        next = "^ca(1,mpc next)^ca()  " 
        font = "^fn(FontAwesome-9)"
        output = font + prev + stop + play_pause + next
        return output

    # def battery():
    #     input = subprocess.check_output(["acpitool", "-B"], universal_newlines=True)
    #     if re.sub(r'.*:\s(.*)', r'\1', input.splitlines()[0]) == "<not available>": #check if acpitool returns "slot empty"
    #         return ""
    #     status = int(round( float(re.sub(r'.*,\s([\d.]+)%.*', r'\1', input.splitlines()[1]) ), 0) )
    #     if re.sub(r'.*:\s(.*)', r'\1', input.splitlines()[6]) in "charged":
    #         symbol = ""
    #     elif re.sub(r'.*:\s(.*)', r'\1', input.splitlines()[6]) in "charging":
    #         if round_number == 0:
    #             symbol = ""
    #         elif round_number in range(2, 4):
    #             symbol = ""
    #         elif round_number in range(4, 6):
    #             symbol = ""
    #         elif round_number in range(6, 8):
    #             symbol = ""
    #         elif round_number in range(8, 10):
    #             symbol = ""
    #     else:
    #         if status in range(0, 21,):
    #             symbol = ""
    #         elif status in range(21, 41):
    #             symbol = ""
    #         elif status in range(41, 61):
    #             symbol = ""
    #         elif status in range(61, 81):
    #             symbol = ""
    #         elif status in range(81, 101):
    #             symbol = ""
    #     return symbol_font + symbol + default + space + str(status) + "%" + sep

    def ram():
        input = subprocess.check_output(["free", "-m"], universal_newlines=True)
        mem_used = int( re.sub(r'.*:\s+\S+\s+(\d+).*', r'\1', input.splitlines()[1]) )
        if mem_used > 1000:
            mem_used = str( round(mem_used / 1024, 2) ) + "G"
        else:
            mem_used = str(mem_used  ) + "M"
        # mem_total = int(re.sub(r'.*:\s+(\d+).*', r'\1', input.splitlines()[1]) ) # not working cause int
        mem_total = float(re.sub(r'.*:\s+(\d+).*', r'\1', input.splitlines()[1]) )
        if mem_total > 1000:
            mem_total = str( round(mem_total/1024, 2) ) + "G"
        else:
            mem_total = str( mem_total ) + "M"
        symbol = ""
        return symbol_font + symbol + default + space + mem_used + "/" + mem_total

    def disk_space():
        input = subprocess.check_output(["df", "-m"], universal_newlines=True)
        # free_disk_space = round( int( re.search(r'\s+(\S+)\s+\S+\s+/\n', input).group(1) ) / 1000, 2 ) # not working cause int
        free_disk_space = round( float( re.search(r'\s+(\S+)\s+\S+\s+/\n', input).group(1) ) / 1024, 2 )
        symbol = ""
        return symbol_font + symbol + default + space + str(free_disk_space) + "G"

    def net():
        # if re.search(r'\n(w\S+):', subprocess.check_output(["ifconfig"], universal_newlines=True) ) == None:
        #     return ""
        input = subprocess.check_output(["nmcli", "d"], universal_newlines=True)
        wifi = re.search(r'wifi\s+(\S+)\s+(\S+)', input)
        if wifi.group(1) in "connected":
            wifi_name = wifi.group(2)[:10]
            symbol = ""
            return symbol_font + symbol + default + space + wifi_name + sep
        else:
            return ""

    if mpd_check() in ('playing', 'paused'):
        mpd = mpd() + "  " + str(mpd_controls()) + sep
        # mpd_controls = "  " + str(mpd_controls())
    elif mpd_check() == False:
        mpd = ""
        # mpd_controls = ""


    print(disk_space() + sep + ram() + sep + net() + mpd + volume() + sep + brightness() + sep + clock() + space)
    # os.system("conky | dzen2 ")
    if round_number == 9:
        round_number = 2
    else:
        round_number = round_number +1
    time.sleep(0.5)
    

