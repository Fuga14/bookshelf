# Bookshelf

A Rails 8 application for managing your book collection.

## Getting Started

### Prerequisites

- Ruby 3.4.2 (see `.ruby-version`)
- PostgreSQL 9.3 or higher
- Bundler

### Database Setup

This application uses PostgreSQL. You have two options to run the database:

#### Option 1: Using Docker (Recommended)

The easiest way to run PostgreSQL is using Docker Compose:

1. **Start the database:**

   ```bash
   docker-compose up -d db
   ```

2. **Create the databases:**

   ```bash
   bin/rails db:create
   ```

3. **Run migrations:**

   ```bash
   bin/rails db:migrate
   ```

4. **Seed the database (optional):**

   ```bash
   bin/rails db:seed
   ```

5. **Stop the database (when done):**
   ```bash
   docker-compose down
   ```

#### Option 2: Local PostgreSQL Installation

1. **Install PostgreSQL on macOS:**

   ```bash
   brew install postgresql@16
   brew services start postgresql@16
   ```

2. **Create the databases:**

   ```bash
   bin/rails db:create
   ```

3. **Run migrations:**

   ```bash
   bin/rails db:migrate
   ```

4. **Seed the database (optional):**
   ```bash
   bin/rails db:seed
   ```

### Running the Application

1. **Install dependencies:**

   ```bash
   bundle install
   ```

2. **Start the Rails server:**

   ```bash
   bin/dev
   ```

   Or use:

   ```bash
   bin/rails server
   ```

3. Visit `http://localhost:3000`

### Database Configuration

The database configuration is in `config/database.yml`. By default:

- Development database: `bookshelf_development`
- Test database: `bookshelf_test`
- Production database: `bookshelf_production`

If using Docker Compose, the database will be available at `localhost:5432` with:

- Username: `postgres`
- Password: `postgres` (change in production!)
- Database: `bookshelf_development`

### Useful Database Commands

- **Open database console:**

  ```bash
  bin/rails dbconsole
  ```

- **Reset database (drops, creates, migrates, seeds):**

  ```bash
  bin/rails db:reset
  ```

- **Rollback last migration:**
  ```bash
  bin/rails db:rollback
  ```

### Checking Database Status

Here are several ways to check if your database is running:

#### If using Docker:

1. **Check if the container is running:**

   ```bash
   docker ps --filter "name=bookshelf_db"
   ```

2. **Check container logs:**

   ```bash
   docker-compose logs db
   ```

3. **Test connection via Rails:**
   ```bash
   bin/rails runner "ActiveRecord::Base.connection.execute('SELECT version()')"
   ```

#### If using local PostgreSQL:

1. **Check Homebrew service status:**

   ```bash
   brew services list | grep postgresql
   ```

2. **Check if PostgreSQL is listening on port 5432:**

   ```bash
   lsof -i :5432
   ```

3. **Test connection via Rails:**

   ```bash
   bin/rails runner "ActiveRecord::Base.connection.execute('SELECT version()')"
   ```

4. **Open database console (if connection works):**
   ```bash
   bin/rails dbconsole
   ```

#### Quick connection test:

The easiest way to test if your database is accessible is:

```bash
bin/rails db:version
```

This will show the current database schema version if the connection is successful, or an error if the database is not accessible.
