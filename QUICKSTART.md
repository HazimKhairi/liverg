# Quick Start Guide

## 🚀 For Running the Application NOW

If you just want to get your JSP project running quickly, follow these steps:

### 1. Database is Already Setup ✓

The database `rgscoring` has been created and populated with sample data.

### 2. Project is Already Built ✓

The WAR file is ready to deploy at:
```
dist/RythmicGymnasticScoringSystem.war (101MB)
```

### 3. Choose Your Deployment Method

#### Option A: Using Apache Tomcat 10+

1. **Install Tomcat 10** (if not already installed):
   ```bash
   brew install tomcat@10
   ```

2. **Deploy the WAR**:
   ```bash
   cp dist/RythmicGymnasticScoringSystem.war /opt/homebrew/opt/tomcat@10/libexec/webapps/
   ```

3. **Start Tomcat**:
   ```bash
   /opt/homebrew/opt/tomcat@10/bin/catalina run
   ```

4. **Access the application**:
   ```
   http://localhost:8080/RythmicGymnasticScoringSystem/
   ```

#### Option B: Using GlassFish 7

1. **Install GlassFish 7**:
   - Download from: https://glassfish.org/download
   - Extract to your preferred location

2. **Start GlassFish**:
   ```bash
   /path/to/glassfish7/bin/asadmin start-domain
   ```

3. **Deploy**:
   ```bash
   /path/to/glassfish7/bin/asadmin deploy dist/RythmicGymnasticScoringSystem.war
   ```

4. **Access the application**:
   ```
   http://localhost:8080/RythmicGymnasticScoringSystem/
   ```

#### Option C: Using NetBeans IDE (Easiest!)

1. **Open NetBeans IDE**
2. **File → Open Project** → Select the `liverg` folder
3. **Right-click project → Properties → Run**:
   - Select your server (Tomcat 10 or GlassFish 7)
4. **Press F6** or right-click → **Run**

NetBeans will automatically build and deploy!

### 4. Login to the Application

Once deployed, use these credentials:

| Role | Username | Password |
|------|----------|----------|
| **Superadmin** | `superadmin` | `superadmin123` |
| Clerk | `clerk` | `123` |
| Staff | `staff` | `staff` |
| Head Judge | `headjudge` | `123` |

---

## If You Need to Rebuild

### Full Clean Build
```bash
cd /Applications/XAMPP/xamppfiles/htdocs/Client_Project/liverg
./build.sh
```

The WAR file will be recreated at `dist/RythmicGymnasticScoringSystem.war`

---

## Troubleshooting

### "Database connection failed"
Make sure XAMPP MySQL is running:
```bash
sudo /Applications/XAMPP/xamppfiles/xampp startmysql
```

### "Application not found (404)"
- Ensure the WAR was copied to the correct webapps directory
- Check server logs for deployment errors

### "Internal Server Error (500)"
- Check server logs:
  - Tomcat: `/opt/homebrew/opt/tomcat@10/libexec/logs/catalina.out`
  - GlassFish: `glassfish7/glassfish/domains/domain1/logs/server.log`

---

## What's Included

✅ Database with 18 tables and sample data
✅ Modern MySQL driver (com.mysql.cj.jdbc.Driver)
✅ All required libraries in WEB-INF/lib
✅ Compiled WAR file ready for deployment (101MB)
✅ Comprehensive documentation

---

## Next Steps

1. Choose and install an application server (Tomcat 10 or GlassFish 7)
2. Deploy the WAR file
3. Access http://localhost:8080/RythmicGymnasticScoringSystem/
4. Login with superadmin credentials
5. Start using the Rhythmic Gymnastics Scoring System!

For detailed documentation, see:
- [README.md](README.md) - Project overview
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Detailed setup instructions
- [BUILD_DEPLOY.md](BUILD_DEPLOY.md) - Build and deployment guide
