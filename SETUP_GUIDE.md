# Setup Guide - Rhythmic Gymnastics Scoring System

This guide will help you set up and run the Rhythmic Gymnastics Scoring System on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 17 or later**
   - Download from: https://www.oracle.com/java/technologies/downloads/
   - Verify installation: `java -version`

2. **Apache Tomcat 10.x or GlassFish 7.x**
   - Tomcat 10: https://tomcat.apache.org/download-10.cgi
   - GlassFish 7: https://glassfish.org/download
   - **Note**: This project requires Jakarta EE 10, so older Tomcat versions (8.x, 9.x) will NOT work

3. **XAMPP with MySQL**
   - Already installed at: `/Applications/XAMPP`
   - Ensure MySQL is running

4. **Apache Ant** (for building the project)
   - Install via Homebrew: `brew install ant`
   - Or download from: https://ant.apache.org/

## Step 1: Database Setup

### Start MySQL Service

1. Open XAMPP Control Panel or use terminal:
   ```bash
   sudo /Applications/XAMPP/xamppfiles/xampp startmysql
   ```

2. Verify MySQL is running:
   ```bash
   /Applications/XAMPP/xamppfiles/bin/mysql -u root -e "SELECT VERSION();"
   ```

### Create Database

Navigate to the project directory and import the SQL file:

```bash
cd /Applications/XAMPP/xamppfiles/htdocs/Client_Project/liverg
/Applications/XAMPP/xamppfiles/bin/mysql -u root < sql/rgscoring.sql
```

### Verify Database Creation

```bash
/Applications/XAMPP/xamppfiles/bin/mysql -u root -e "USE rgscoring; SHOW TABLES;"
```

You should see a list of tables including: `apparatus`, `clerk`, `event`, `gymnast`, `judge`, `score`, `team`, etc.

## Step 2: Build the Project

### Using Apache Ant

1. Navigate to project directory:
   ```bash
   cd /Applications/XAMPP/xamppfiles/htdocs/Client_Project/liverg
   ```

2. Clean previous builds:
   ```bash
   ant clean
   ```

3. Build the WAR file:
   ```bash
   ant dist
   ```

4. The WAR file will be created at:
   ```
   dist/RythmicGymnasticScoringSystem.war
   ```

## Step 3: Deploy to Application Server

### Option A: Apache Tomcat 10

1. **Copy WAR file to Tomcat webapps directory:**
   ```bash
   cp dist/RythmicGymnasticScoringSystem.war /path/to/tomcat10/webapps/
   ```

2. **Start Tomcat:**
   ```bash
   /path/to/tomcat10/bin/catalina.sh run
   ```
   Or on Windows: `catalina.bat run`

3. **Wait for deployment** (watch the logs for "Deployment of web application archive ... has finished")

### Option B: GlassFish 7

1. **Start GlassFish:**
   ```bash
   /path/to/glassfish7/bin/asadmin start-domain
   ```

2. **Deploy the WAR:**
   ```bash
   /path/to/glassfish7/bin/asadmin deploy dist/RythmicGymnasticScoringSystem.war
   ```

3. **Or use the Admin Console:**
   - Navigate to: http://localhost:4848
   - Go to Applications → Deploy
   - Select the WAR file

### Option C: NetBeans IDE (Easiest)

If you're using NetBeans:

1. Open the project in NetBeans
2. Right-click the project → Run
3. NetBeans will automatically deploy to the configured server

## Step 4: Access the Application

Once deployed, access the application at:

**Tomcat:** http://localhost:8080/RythmicGymnasticScoringSystem/

**GlassFish:** http://localhost:8080/RythmicGymnasticScoringSystem/

### Default Login Credentials

The system has the following default users:

| Role | Username | Password |
|------|----------|----------|
| Clerk | `clerk` | `123` |
| Superadmin | `superadmin` | `superadmin123` |
| Staff | `staff` | `staff` |
| Head Judge | `headjudge` | `123` |

## Step 5: Verify Installation

### Test Database Connection

Navigate to: http://localhost:8080/RythmicGymnasticScoringSystem/testDB.jsp

You should see a success message indicating the database connection is working.

### Test Main Features

1. **Login as Superadmin:**
   - Username: `superadmin`
   - Password: `superadmin123`

2. **Verify you can access:**
   - Event Management
   - Organization Management
   - Dashboard

## Troubleshooting

### Database Connection Errors

**Error: "No suitable driver found for jdbc:mysql"**
- Ensure `mysql-connector-j-8.4.0.jar` is in `web/WEB-INF/lib/`
- Rebuild and redeploy the application

**Error: "Access denied for user 'root'"**
- Check MySQL is running: `sudo /Applications/XAMPP/xamppfiles/xampp startmysql`
- Verify credentials in `src/java/com/connection/DBConnect.java`

**Error: "Unknown database 'rgscoring'"**
- Database not created. Re-run: `/Applications/XAMPP/xamppfiles/bin/mysql -u root < sql/rgscoring.sql`

### Server Errors

**Error: "HTTP Status 404 – Not Found"**
- Verify the WAR file deployed successfully
- Check server logs for deployment errors
- Ensure context path matches URL

**Error: "HTTP Status 500 – Internal Server Error"**
- Check server logs: `tail -f /path/to/tomcat/logs/catalina.out`
- Verify all JAR files are in `WEB-INF/lib/`
- Ensure Java 17+ is being used

**JSP/JSTL Errors**
- Verify JSTL libraries are in `web/WEB-INF/lib/`:
  - `jakarta.servlet.jsp.jstl-2.0.0.jar`
  - `jakarta.servlet.jsp.jstl-api-2.0.0.jar`

### Port Conflicts

If port 8080 is already in use:

**For Tomcat:**
- Edit `conf/server.xml`
- Change `<Connector port="8080"` to another port (e.g., 8081)

**For GlassFish:**
- Use `asadmin set server.http-service.http-listener.http-listener-1.port=8081`

## Project Structure

```
liverg/
├── build.xml              # Ant build configuration
├── nbproject/            # NetBeans project files
├── src/
│   └── java/             # Java source files
│       └── com/
│           ├── connection/   # Database connection
│           ├── dao/          # Data Access Objects
│           ├── registration/ # Registration servlets
│           ├── servlet/      # Application servlets
│           └── query/        # Query servlets
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml       # Web application configuration
│   │   └── lib/          # Runtime libraries (JAR files)
│   ├── *.jsp             # JSP pages
│   ├── registration/     # Registration module JSPs
│   └── scoring/          # Scoring module JSPs
├── lib/                  # Build-time libraries
└── sql/
    └── rgscoring.sql     # Database schema and data
```

## Next Steps

After successful setup:

1. Review the application features
2. Configure events and organizations
3. Add gymnasts, judges, and teams
4. Start scoring competitions

For build and deployment details, see [BUILD_DEPLOY.md](BUILD_DEPLOY.md).

## Support

For issues or questions, refer to the project documentation or check the server logs for detailed error messages.
