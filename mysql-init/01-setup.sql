-- MySQL initialization for EspoCRM Kwame Oil and Gas
-- This script will run when MySQL container starts for the first time

-- Ensure proper charset and collation
ALTER DATABASE espocrm_kwame CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant all privileges to the user
GRANT ALL PRIVILEGES ON espocrm_kwame.* TO 'espocrm_user'@'%';

-- Optimize MySQL for EspoCRM
SET GLOBAL innodb_buffer_pool_size = 268435456; -- 256MB
SET GLOBAL max_connections = 100;
SET GLOBAL query_cache_type = 1;
SET GLOBAL query_cache_size = 16777216; -- 16MB

FLUSH PRIVILEGES;