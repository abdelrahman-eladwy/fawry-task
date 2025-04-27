Let's systematically work through the troubleshooting process:
1. Verify DNS Resolution:
  1.1 # Check the system's DNS configuration
   -cat /etc/resolv.conf
   
   1.2# Query using system's DNS servers
   ![image](https://github.com/user-attachments/assets/3fb0899e-a915-4588-b519-faf514b882b7)

   1.3 # Query using Google's DNS (8.8.8.8)
   ![image](https://github.com/user-attachments/assets/84c533a4-5636-415b-ad3e-2741d4cc5549)
   
  -Possible outcomes:
   Both resolve to the same IP → DNS is consistent
   Different IPs → DNS inconsistency between internal and external servers
   No resolution with internal DNS but resolves with external → Internal DNS issue
   No resolution with either → Domain might not be in any DNS or complete network issue

   
