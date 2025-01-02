### **Dingosdevelopment_JobCreator Installation Guide**

Bring powerful job creation and management to your FiveM server with the **Dingosdevelopment_JobCreator** script. Follow the steps below to install and get started!

---

### **1. Download Required Resources**
1. **Dingosdevelopment_JobCreator**:  
   [Download Here](https://github.com/Dingos-Development/Job-Creator)

2. **NativeUI**:  
   [Download Here](https://github.com/FrazzIe/NativeUILua)  

---

### **2. Install the Resources**
1. **Add NativeUI to Your Server**:
   - Download the NativeUI resource from the link above.
   - Place the folder into your `resources` directory.
   - Add the following line to your `server.cfg`:
     ```plaintext
     ensure NativeUI
     ```

2. **Add Dingosdevelopment_JobCreator**:
   - Download the resource from the provided link.
   - Place the `Dingosdevelopment_JobCreator` folder into your `resources` directory.
   - Add the following line to your `server.cfg`:
     ```plaintext
     ensure Dingosdevelopment_JobCreator
     ```

---

### **3. Configure the Script**
1. Open the `config.lua` file inside the `Dingosdevelopment_JobCreator` folder.
2. Configure your preferred billing and job systems:
   ```lua
   Config.BillingSystem = "okokBilling" -- Options: "okokBilling", "qb-banking"
   Config.JobSystem = "ps-multijob"     -- Options: "ps-multijob", "qb-jobs"
   ```
3. (Optional) Enable debug mode for troubleshooting:
   ```lua
   Config.Debug = true -- Set to true for detailed logs
   ```

---

### **4. Start the Server**
- Restart your FiveM server.
- Run the following command in the console to ensure everything is loaded:
  ```plaintext
  restart Dingosdevelopment_JobCreator
  ```

---

### **5. Test the Command**
1. Join your server.
2. Type `/jobcreator` in the chat to open the Job Creator menu.
3. Use the intuitive menu to add or manage jobs effortlessly.

---

### **Need Support?**
Join our **Support Discord** for assistance:  
📞 **[Support Discord](https://discord.gg/gxcZgsghzn)**

**Author**: Dingo's Development  



