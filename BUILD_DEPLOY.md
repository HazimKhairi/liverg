# Build and Deployment Guide

This document provides detailed instructions for building and deploying the Rhythmic Gymnastics Scoring System.

## Building the Project

### Prerequisites

- Apache Ant installed
- Java JDK 17+ configured
- All dependencies in `lib/` directory

### Build Commands

#### Clean Build

Remove all previously compiled files:

```bash
cd /Applications/XAMPP/xamppfiles/htdocs/Client_Project/liverg
ant clean
```

#### Compile Only

Compile Java sources without creating WAR:

```bash
ant compile
```

#### Create WAR File

Build the complete deployable WAR file:

```bash
ant dist
```

This creates: `dist/RythmicGymnasticScoringSystem.war`

#### Clean and Build

Clean previous builds and create fresh WAR:

```bash
ant clean dist
```

### Verify Build

After building, verify the WAR contents:

```bash
jar -tf dist/RythmicGymnasticScoringSystem.war | head -20
```

Ensure the following are present:
- `WEB-INF/classes/` - Compiled Java classes
- `WEB-INF/lib/` - All JAR dependencies
- `WEB-INF/web.xml` - Deployment descriptor
- `*.jsp` - JSP pages

## Deployment Options

### Option 1: Apache Tomcat 10.x

#### Manual Deployment

1. **Stop Tomcat** (if running):
   ```bash
   $CATALINA_HOME/bin/shutdown.sh
   ```

2. **Remove old deployment** (if exists):
   ```bash
   rm -rf $CATALINA_HOME/webapps/RythmicGymnasticScoringSystem*
   ```

3. **Copy WAR file**:
   ```bash
   cp dist/RythmicGymnasticScoringSystem.war $CATALINA_HOME/webapps/
   ```

4. **Start Tomcat**:
   ```bash
   $CATALINA_HOME/bin/catalina.sh run
   ```
   Or in background: `$CATALINA_HOME/bin/startup.sh`

5. **Monitor deployment**:
   ```bash
   tail -f $CATALINA_HOME/logs/catalina.out
   ```

#### Hot Deployment

If Tomcat is running with auto-deploy enabled:

```bash
cp dist/RythmicGymnasticScoringSystem.war $CATALINA_HOME/webapps/
```

Tomcat will automatically detect and deploy the WAR.

#### Tomcat Manager (Web UI)

1. Access: http://localhost:8080/manager/html
2. Scroll to "WAR file to deploy"
3. Click "Choose File" and select the WAR
4. Click "Deploy"

### Option 2: GlassFish 7.x

#### Command Line Deployment

1. **Start GlassFish domain**:
   ```bash
   $GLASSFISH_HOME/bin/asadmin start-domain
   ```

2. **Deploy application**:
   ```bash
   $GLASSFISH_HOME/bin/asadmin deploy dist/RythmicGymnasticScoringSystem.war
   ```

3. **Verify deployment**:
   ```bash
   $GLASSFISH_HOME/bin/asadmin list-applications
   ```

#### Admin Console Deployment

1. Access: http://localhost:4848
2. Navigate to: Applications → Deploy
3. Select "Packaged File to Be Uploaded to the Server"
4. Browse to `dist/RythmicGymnasticScoringSystem.war`
5. Click "OK"

#### Redeployment

If application is already deployed:

```bash
$GLASSFISH_HOME/bin/asadmin redeploy dist/RythmicGymnasticScoringSystem.war
```

Or undeploy first:

```bash
$GLASSFISH_HOME/bin/asadmin undeploy RythmicGymnasticScoringSystem
$GLASSFISH_HOME/bin/asadmin deploy dist/RythmicGymnasticScoringSystem.war
```

### Option 3: NetBeans IDE

#### First Time Deployment

1. Open project in NetBeans
2. Right-click project → Properties
3. Run → Server: Select your configured server (Tomcat/GlassFish)
4. Click OK
5. Right-click project → Run

#### Subsequent Deployments

Simply press **F6** or right-click project → Run

NetBeans handles:
- Building the project
- Deploying to server
- Opening browser to application URL

## Configuration

### Database Connection

Edit `src/java/com/connection/DBConnect.java` if needed:

```java
private String jdbcURL = "jdbc:mysql://localhost:3306/rgscoring?useSSL=false&serverTimezone=UTC";
private String jdbcUsername = "root";
private String jdbcPassword = "";
```

**After changes:** Rebuild and redeploy.

### Server Configuration

#### Tomcat Memory Settings

Edit `$CATALINA_HOME/bin/setenv.sh` (create if doesn't exist):

```bash
export CATALINA_OPTS="$CATALINA_OPTS -Xms512m -Xmx1024m"
```

#### GlassFish JVM Options

```bash
$GLASSFISH_HOME/bin/asadmin create-jvm-options "-Xmx1024m"
$GLASSFISH_HOME/bin/asadmin create-jvm-options "-Xms512m"
```

### Context Path

By default, the application deploys to: `/RythmicGymnasticScoringSystem`

To change:

**Tomcat:** Rename WAR file (e.g., `ROOT.war` → deploys to `/`)

**GlassFish:** Use `--contextroot` parameter:
```bash
asadmin deploy --contextroot /myapp dist/RythmicGymnasticScoringSystem.war
```

## Development Workflow

### Quick Redeploy Cycle

1. Make code changes
2. Build: `ant dist`
3. Redeploy (Tomcat):
   ```bash
   cp dist/RythmicGymnasticScoringSystem.war $CATALINA_HOME/webapps/
   ```
4. Wait for hot deployment or restart server

### Debug Mode

#### Tomcat Debug

Start Tomcat in debug mode:

```bash
$CATALINA_HOME/bin/catalina.sh jpda run
```

Default debug port: 8000

#### NetBeans Debug

1. Right-click project → Debug
2. Set breakpoints in code
3. NetBeans connects automatically

## Production Deployment

### Pre-Deployment Checklist

- [ ] Update database credentials
- [ ] Remove test accounts or change passwords
- [ ] Enable HTTPS/SSL
- [ ] Configure proper error pages
- [ ] Set production logging levels
- [ ] Disable directory listing
- [ ] Review security settings in `web.xml`

### Security Hardening

1. **Change default passwords** in database:
   ```sql
   UPDATE clerk SET clerkPassword = 'new_secure_password' WHERE clerkUsername = 'clerk';
   UPDATE staff SET staffPassword = 'new_secure_password' WHERE staffUsername = 'superadmin';
   ```

2. **Configure HTTPS** in Tomcat/GlassFish

3. **Set secure session cookies** in `web.xml`:
   ```xml
   <session-config>
       <cookie-config>
           <secure>true</secure>
           <http-only>true</http-only>
       </cookie-config>
   </session-config>
   ```

### Performance Optimization

1. **Enable GZIP compression** in server
2. **Configure connection pooling** for database
3. **Set appropriate JVM heap size**
4. **Enable caching** for static resources

## Troubleshooting Deployment

### Build Failures

**Error: "Unable to find javac compiler"**
- Ensure JDK (not JRE) is installed
- Set `JAVA_HOME` environment variable

**Error: "package jakarta.servlet does not exist"**
- Server libraries not in classpath
- Verify `j2ee.platform.classpath` in `nbproject/project.properties`

### Deployment Failures

**Error: "ClassNotFoundException: com.mysql.cj.jdbc.Driver"**
- Missing MySQL connector in `WEB-INF/lib/`
- Rebuild: `ant clean dist`

**Error: "java.lang.UnsupportedClassVersionError"**
- JDK/JRE version mismatch
- Ensure both build and runtime use Java 17+

**Servlets not found (404 errors)**
- Check `web.xml` servlet mappings
- Verify compiled classes in `WEB-INF/classes/`

### Runtime Issues

**Application starts but shows errors**
1. Check server logs:
   - Tomcat: `$CATALINA_HOME/logs/catalina.out`
   - GlassFish: `$GLASSFISH_HOME/glassfish/domains/domain1/logs/server.log`

2. Enable detailed logging in `java.util.logging.config.file`

**Database connection fails**
1. Verify MySQL is running: `mysqladmin -u root status`
2. Test connection: `/Applications/XAMPP/xamppfiles/bin/mysql -u root -e "USE rgscoring;"`
3. Check credentials in `DBConnect.java`

## Useful Commands

### Tomcat

```bash
# Start
$CATALINA_HOME/bin/startup.sh

# Stop
$CATALINA_HOME/bin/shutdown.sh

# View logs
tail -f $CATALINA_HOME/logs/catalina.out

# List deployed apps
ls -la $CATALINA_HOME/webapps/
```

### GlassFish

```bash
# Start domain
asadmin start-domain

# Stop domain
asadmin stop-domain

# List applications
asadmin list-applications

# Undeploy
asadmin undeploy RythmicGymnasticScoringSystem

# View logs
tail -f $GLASSFISH_HOME/glassfish/domains/domain1/logs/server.log
```

### Database

```bash
# Import SQL
/Applications/XAMPP/xamppfiles/bin/mysql -u root rgscoring < sql/rgscoring.sql

# Backup database
/Applications/XAMPP/xamppfiles/bin/mysqldump -u root rgscoring > backup.sql

# Access MySQL shell
/Applications/XAMPP/xamppfiles/bin/mysql -u root rgscoring
```

## Quick Reference

| Task | Command |
|------|---------|
| Build WAR | `ant dist` |
| Clean build | `ant clean dist` |
| Deploy to Tomcat | `cp dist/*.war $CATALINA_HOME/webapps/` |
| Deploy to GlassFish | `asadmin deploy dist/*.war` |
| View Tomcat logs | `tail -f $CATALINA_HOME/logs/catalina.out` |
| View GlassFish logs | `tail -f $GLASSFISH_HOME/.../server.log` |
| Test locally | http://localhost:8080/RythmicGymnasticScoringSystem/ |

## Support

For setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md).
