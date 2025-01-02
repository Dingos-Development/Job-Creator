Here’s your updated installation guide, tailored for the new changes:

---

### **Dingosdevelopment_JobCreator Installation Guide**

Bring powerful job creation and management to your FiveM server with the **Dingosdevelopment_JobCreator** script. Follow the steps below to install and get started!

---

### **1. Download Required Resources**
1. **Dingosdevelopment_JobCreator**:  
   [Download Here](https://github.com/Dingos-Development/Job-Creator)

2. **ox_lib**:  
   [Download Here](https://github.com/overextended/ox_lib)

---

### **2. Install the Resources**
1. **Add ox_lib to Your Server**:
   - Download the ox_lib resource from the link above.
   - Place the folder into your `resources` directory.
   - Add the following line to your `server.cfg`:
     ```plaintext
     ensure ox_lib
     ```
   - Run the `ox_lib` database migration if required. Check their GitHub documentation for details.

2. **Add Dingosdevelopment_JobCreator**:
   - Download the resource from the provided link.
   - Place the `Dingosdevelopment_JobCreator` folder into your `resources` directory.
   - Add the following line to your `server.cfg`:
     ```plaintext
     ensure Dingosdevelopment_JobCreator
     ```

---

### **3. Set Up the Database**
1. Create the `jobs` table in your database by running the following SQL script:
   ```sql
   CREATE TABLE IF NOT EXISTS `jobs` (
       `id` VARCHAR(50) NOT NULL PRIMARY KEY,
       `label` VARCHAR(100) NOT NULL,
       `grade1_salary` INT NOT NULL DEFAULT 0,
       `grade2_salary` INT NOT NULL DEFAULT 0,
       `grade3_salary` INT NOT NULL DEFAULT 0,
       `grade4_salary` INT NOT NULL DEFAULT 0
   );
   ```

2. Verify that the `jobs` table has been created successfully.

---

### **4. Configure the Script**
1. Open the `config.lua` file inside the `Dingosdevelopment_JobCreator` folder.
2. Configure your preferred billing and job systems:
   ```lua
   Config.BillingSystem = "okokBilling" -- Options: "okokBilling", "qb-banking"
   Config.JobSystem = "qb-jobs"         -- Options: "ps-multijob", "qb-jobs"
   ```
3. (Optional) Enable debug mode for troubleshooting:
   ```lua
   Config.Debug = true -- Set to true for detailed logs
   ```

---

### **5. Start the Server**
- Restart your FiveM server.
- Run the following command in the console to ensure everything is loaded:
  ```plaintext
  restart Dingosdevelopment_JobCreator
  ```

---

### **6. Test the Command**
1. Join your server.
2. Type `/jobcreator` in the chat to open the Job Creator menu.
3. Use the intuitive menu to:
   - Add new jobs.
   - Edit job salaries.
   - View all current jobs.

---

### **Need Support?**
Join our **Support Discord** for assistance:  
📞 **[Support Discord](https://discord.gg/gxcZgsghzn)**

**Author**: Dingo's Development  
