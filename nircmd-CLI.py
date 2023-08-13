import os
import sys
import subprocess
import ctypes
import colorama

def run_ncms_script(script_filename):
    with open(script_filename, "r") as script_file:
        lines = script_file.readlines()
        for line in lines:
            command = line.strip()
            subprocess.run(["nircmd.exe"] + command.split(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def show_error_dialog(message):
    ctypes.windll.user32.MessageBoxW(0, message, "Error", 0)

def main():
    colorama.init()

    if len(sys.argv) > 1:
        script_filename = sys.argv[1]
        _, file_extension = os.path.splitext(script_filename)
        if file_extension.lower() == ".ncms":
            run_ncms_script(script_filename)
        else:
            show_error_dialog("Only .ncms files can be executed.")
    else:
        print(colorama.Fore.LIGHTBLUE_EX + "Program window will open if any incomplete commands are executed.")
        print("Nircmd CLI Interface 1.0.0" + colorama.Style.RESET_ALL + "\n")
        while True:
            user_input = input(f"{colorama.Fore.LIGHTBLUE_EX}{os.getcwd()}>{colorama.Style.RESET_ALL} ")
            if user_input == "":
                continue
            elif user_input.lower() == "cd":
                print("Please specify a valid directory path.")
            elif user_input.startswith("cd "):
                directory = user_input[3:].strip()
                if directory == "..":
                    os.chdir("..")
                else:
                    try:
                        os.chdir(directory)
                    except OSError:
                        print("Invalid directory:", directory)
            elif user_input.lower() == "help":
                help_file_path = os.path.join(os.getcwd(), "NirCmd.chm")
                os.startfile(help_file_path)
            else:
                subprocess.run(["nircmd.exe"] + user_input.split(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

if __name__ == "__main__":
    main()
