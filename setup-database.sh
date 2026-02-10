#!/bin/bash

# Quick Database Setup Script
# This script sets up the MySQL database for the Rhythmic Gymnastics Scoring System

echo "=========================================="
echo "Rhythmic Gymnastics Scoring System"
echo "Database Setup Script"
echo "=========================================="
echo ""

# Configuration
MYSQL_BIN="/Applications/XAMPP/xamppfiles/bin/mysql"
MYSQL_USER="root"
MYSQL_PASSWORD=""
DATABASE_NAME="rgscoring"
SQL_FILE="sql/rgscoring.sql"

# Check if MySQL is running
echo "Checking if MySQL is running..."
if ! pgrep -x "mysqld" > /dev/null; then
    echo "ERROR: MySQL is not running!"
    echo "Please start MySQL first:"
    echo "  sudo /Applications/XAMPP/xamppfiles/xampp startmysql"
    exit 1
fi

echo "✓ MySQL is running"
echo ""

# Check if SQL file exists
if [ ! -f "$SQL_FILE" ]; then
    echo "ERROR: SQL file not found: $SQL_FILE"
    echo "Please ensure you're running this script from the project root directory"
    exit 1
fi

echo "✓ SQL file found: $SQL_FILE"
echo ""

# Import database
echo "Importing database..."
if [ -z "$MYSQL_PASSWORD" ]; then
    $MYSQL_BIN -u $MYSQL_USER < "$SQL_FILE" 2>&1
else
    $MYSQL_BIN -u $MYSQL_USER -p"$MYSQL_PASSWORD" < "$SQL_FILE" 2>&1
fi

if [ $? -eq 0 ]; then
    echo "✓ Database imported successfully"
    echo ""
else
    echo "✗ Failed to import database"
    echo "Please check the error messages above"
    exit 1
fi

# Verify database
echo "Verifying database setup..."
TABLE_COUNT=$($MYSQL_BIN -u $MYSQL_USER -e "USE $DATABASE_NAME; SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$DATABASE_NAME';" -N 2>/dev/null | tail -1)

if [ -n "$TABLE_COUNT" ] && [ "$TABLE_COUNT" -gt 0 ]; then
    echo "✓ Database verified: $TABLE_COUNT tables found"
    echo ""
    
    # List tables
    echo "Tables in database:"
    $MYSQL_BIN -u $MYSQL_USER -e "USE $DATABASE_NAME; SHOW TABLES;" 2>/dev/null
    echo ""
else
    echo "✗ Database verification failed"
    exit 1
fi

echo "=========================================="
echo "Database setup completed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Build the project: ant clean dist"
echo "2. Deploy to Tomcat/GlassFish"
echo "3. Access: http://localhost:8080/RythmicGymnasticScoringSystem/"
echo ""
echo "Default credentials:"
echo "  Superadmin: superadmin / superadmin123"
echo "  Clerk: clerk / 123"
echo ""
