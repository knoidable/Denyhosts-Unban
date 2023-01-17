# **Denyhosts-Unban**
#### Remove a banned IP from Denyhosts

I wrote this script 10 years ago when I was still administering servers for a gaming community. I haven't had cause to use it in 9 or so years - as such, it may no longer be functional. Fairly sure the /etc/init.d stuff will need to be updated. Hopefully it's useful to someone as a base, though.

Usage:

```
chmod +x ./remove_denied_ip.sh
./remove_denied_ip.sh <IP.Address.To.Unban>
```

Text from my original blog entry follows.

--------------------------------------------------------

###### January 22, 2013

### **Denied By My Own Genius**

I couldn’t connect to one of my servers tonight.

After taking a few minutes to check the server status, I realised that it was still online – but was denying my ssh connection. After logging in from a different machine, I found that DenyHosts had blocked my external IP address.

I’ve managed to do this a few times before, and while it only takes a few minutes to fix, I can never remember where the files are located. Plus I had a few hours to kill, so I thought ‘F@!# it, let’s write a shell script so I don’t have to do this crap again.’

Three hours later (although I did play a couple of games of League in that time too, so probably really about an hour), here’s the result.

Note the quotes in the sed lines – took me a little while to work out what was going on. Turns out that variables are not expanded if they’re contained in single quotes, so sed was trying to remove $1 from the files instead of removing the IP address.

It’s possibly not the best or most efficient script, and I’ll not use it but rarely – but I learned a couple of things, and it doesn’t look like anyone else has put one together yet, so overall I think it was time well spent.
