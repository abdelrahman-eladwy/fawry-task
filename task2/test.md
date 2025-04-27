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

### DNS Issues:
- Internal DNS server malfunction (service stopped or crashed)
- DNS cache issues (stale local or server-side records)
- DNS zone file problems (missing or incorrect entries)
- Split-horizon DNS misconfiguration
- DNS propagation delay after recent changes

### Network/Routing Issues:
- Firewall blocking (on client, network, or server side)
- Routing problems (incorrect routing tables)
- VPN/network segmentation issues (clients isolated on a different network)
- Server IP changed (DNS pointing to wrong IP)
- NIC issues (server’s network interface down or misconfigured)

### Server Issues:
- Web server not running (Apache, Nginx, etc. service down)
- Server overloaded (unable to accept new connections)
- SSL/TLS certificate issues (for HTTPS connections)
- Web server misconfiguration (virtual host issues)
- Host down or rebooting (server completely offline)

---

# ✅ Conclusion
Following this structured approach ensures you methodically identify and resolve the root cause of connectivity issues.

---

