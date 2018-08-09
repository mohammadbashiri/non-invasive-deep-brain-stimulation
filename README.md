# Non-Invasive Deep Brain Stimulation

This repository contains all the code used for simulation and creating the figures in the paper.

### Instruction to add ssh-key

1. Paste the text below, substituting in your GitHub email address

	ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

	Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]<br>
	Enter passphrase (empty for no passphrase): [Type a passphrase]<br>
	Enter same passphrase again: [Type passphrase again]
	
2. Go to /c/Users/you/.ssh/id_rsa. open the id_rsa.pub with notepad, and copy the whole thing.

3. Go to your remote github repo > Settings > Deploy Keys. Press "Add deploy key". Choose a title for the key and paste 
the copied ssh key in the key section

You are done! and you now pull and push to your private repo.