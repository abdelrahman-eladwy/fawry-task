# Troubleshooting Guide

Let's systematically work through the troubleshooting process:

---

## 1. Verify DNS Resolution

### 1.1 Check the system's DNS configuration
```bash
cat /etc/resolv.conf
```

### 1.2 Query using the system's DNS servers
![System DNS Query](https://github.com/user-attachments/assets/3fb0899e-a915-4588-b519-faf514b882b7)

### 1.3 Query using Google's DNS (8.8.8.8)
![Google DNS Query](https://github.com/user-attachments/assets/84c533a4-5636-415b-ad3e-2741d4cc5549)

---

**Possible outcomes:**
- ✅ Both resolve to the same IP → **DNS is consistent**
- ⚠️ Different IPs → **DNS inconsistency between internal and external servers**
- ❌ No resolution with internal DNS but resolves with external → **Internal DNS issue**
- ❌ No resolution with either → **Domain not registered or network issue**

---

## 2. Diagnose Service Reachability

### 2.1 Check if the server is reachable (ICMP Ping)
![Ping Test](https://github.com/user-attachments/assets/81b1715b-d790-4c5b-b268-e5d9c99c6f2d)

### 2.2 If ping fails, try pinging the server's IP directly
![Ping by IP](https://github.com/user-attachments/assets/89f8447c-0a20-4e44-8a84-3b4702406364)

### 2.3 Check if the web port is open using `netcat`
![Netcat Test](https://github.com/user-attachments/assets/0df0ffd9-63e3-4a04-a056-790fec3de932)

### 2.4 Try establishing an HTTP connection
![HTTP Connection Test](https://github.com/user-attachments/assets/9cd0516a-12e8-4c59-b097-74570ca0ba2a)

---

## 3. Trace the Issue - All Possible Causes

### DNS Issues
- Internal DNS server malfunction (service stopped or crashed)
- DNS cache issues (stale local or server-side records)


### Network/Routing Issues
- Firewall blocking (on client, network, or server side)
- Routing problems (incorrect routing tables)


### Server Issues
- Web server not running (Apache, Nginx, etc. service down)
- Web server misconfiguration (virtual host issues)


---

## 4. Propose and Apply Fixes

### 4.1 DNS Server Issues

**Issue:** Internal DNS server malfunction  
- Confirm root cause:  
![DNS Service Check]![image](https://github.com/user-attachments/assets/15f159cb-1bd8-4e19-9f35-a3826592458f)

- Fix:  
![Restart DNS Service]![image](https://github.com/user-attachments/assets/2b346b73-5bae-4206-ab64-ddca6eb41dad)


---

**Issue:** DNS cache issues  
- Check multiple clients, verify TTL:  
![TTL Check](https://github.com/user-attachments/assets/6daf2a09-c172-42c6-aca0-e2d3febc7021)
- Fix: Flush DNS cache  
![Flush Cache]![image](https://github.com/user-attachments/assets/a2887136-4292-4a82-b7d1-edf73c750e6d)


---

### 4.2 Network/Routing Issues

**Issue:** Firewall blocking  
- Confirm with firewall rules check:  
![Firewall Check](https://github.com/user-attachments/assets/fd35d7a9-ffac-470a-b941-8201035f9751)
- Fix: Allow HTTP/HTTPS through firewall  
![Allow Ports](https://github.com/user-attachments/assets/28deecf3-3649-49fc-9055-b137a9f513a8)

---

**Issue:** Routing problems  
- Check route to server:  
![image](https://github.com/user-attachments/assets/eab1329d-fff8-4168-8e0a-c9f1bb440949)
- Check routing table:  
![Routing Table Check](https://github.com/user-attachments/assets/32a9f6ff-2e0f-4640-a36f-b0da438401de)
- Fix: Add static route if needed  
![Add Route](https://github.com/user-attachments/assets/e43e68be-e0af-4153-b47e-c99f7d0f2458)

---

### 4.3 Server Issues

**Issue:** Web server not running  
- Confirm with service status:  
![image](https://github.com/user-attachments/assets/d0792fdf-4497-43aa-b7e4-46be3d4cdc13)
- Check logs:  
![image](https://github.com/user-attachments/assets/25e26ba7-0ae1-463c-8a9d-4a858acdeef5)
- Check which process using port 80
![image](https://github.com/user-attachments/assets/b0622bf4-9011-4cf9-b354-4e87f9ea1583)
- stoping the docker conatiner  
![image](https://github.com/user-attachments/assets/28f7d2e3-e227-4469-931a-f55435e2cb6a)
- restart the service and check the status 
![image](https://github.com/user-attachments/assets/34d7196b-572e-445c-897d-928b652a0439)


---

**Issue:** Web server misconfiguration  
- Confirm with config file checks:  
![image](https://github.com/user-attachments/assets/e8acfe2f-7f02-4062-b25e-307c8962379c)
- Check virtual hosts:  
![image](https://github.com/user-attachments/assets/41bdf8fd-8ae2-480e-9a21-6e5f776fc1fc)
- Fix: Edit and reload  
![Edit Virtual Host](https://github.com/user-attachments/assets/7cfcf662-212c-4f1f-a887-6021a723df3a)  
![Enable Site](https://github.com/user-attachments/assets/a8dab7b0-7c85-41fa-851f-808c127d5df3)  
![Reload Service](https://github.com/user-attachments/assets/aef235b1-f651-455c-bd9f-432dd8fb9394)

---

## 5. Bonus - Local Hosts Entry and Persistent DNS Configuration

### 5.1 Local Hosts Entry
- Edit hosts file:  
![Edit Hosts](https://github.com/user-attachments/assets/13e2f7a1-bdd4-4cb1-9910-598cd54fb8e2)
- Add manual DNS entry:  
![Add Entry](https://github.com/user-attachments/assets/bfc5af40-192c-4f88-be31-e876823d8be4)
- Verify:  
![Verify Hosts Entry](https://github.com/user-attachments/assets/59bdaf83-d604-47d9-9ce3-d1be15bdb404)

---

### 5.2 Persistent DNS Settings
- Using `systemd-resolved`:  
![Edit systemd-resolved](https://github.com/user-attachments/assets/6a6a3027-1e1e-4730-8d18-c7db69d8f57a)
- Add DNS servers:  
![Add DNS Servers](https://github.com/user-attachments/assets/70cd9531-17ba-46f4-a546-12bff5a0d092)
- Restart service:  
![Restart systemd-resolved](https://github.com/user-attachments/assets/ef0c1969-fba5-4978-bd5a-30a0c18ff97d)

---

# ✅ Conclusion
Following this structured approach ensures you methodically identify and resolve the root cause of connectivity issues, from DNS to server misconfigurations.

---

