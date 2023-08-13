import os
import sys
import subprocess
import ctypes
import colorama
import time

def run_ncms_script(script_filename):
    with open(script_filename, "r") as script_file:
        lines = script_file.readlines()

        loop_indices = {}
        
        for idx, line in enumerate(lines):
            if line.strip().startswith(":"):
                loop_name = line.strip()[1:]
                loop_indices[loop_name] = idx
        
        current_line = 0
        while current_line < len(lines):
            line = lines[current_line].strip()
            
            if line.lower() == "exit":
                break
            
            if line.startswith("goto "):
                loop_name = line[5:]
                if loop_name not in loop_indices:
                    show_error_dialog(f"Undeclared Loop named \"{loop_name}\" at Line {current_line + 1}")
                    return
                else:
                    current_line = loop_indices[loop_name]
            elif line.startswith(":"):
                # Skip loop label, no action needed
                pass
            elif line.startswith("wait "):
                try:
                    wait_time = float(line.split()[1])
                except (ValueError, IndexError):
                    wait_time = 5.0  # Default wait time is 5 seconds
                time.sleep(wait_time)
            elif line.startswith("echo "):
                print(line[5:])
            else:
                subprocess.run(["nircmd.exe"] + line.split(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                
            current_line += 1

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
        print("Nircmd CLI Interface 1.1.0" + colorama.Style.RESET_ALL + "\n")
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
                _, file_extension = os.path.splitext(user_input)
                if file_extension.lower() == ".ncms":
                    run_ncms_script(user_input)
                else:
                    subprocess.run(["nircmd.exe"] + user_input.split(), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

if __name__ == "__main__":
    main()
