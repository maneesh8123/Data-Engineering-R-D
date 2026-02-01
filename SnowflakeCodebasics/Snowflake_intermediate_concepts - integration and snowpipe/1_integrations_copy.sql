CREATE OR REPLACE STORAGE INTEGRATION int_s3_sales_db
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::521926169599:role/snowflake-si-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://sales-dhaval-sf-1/');

DESC INTEGRATION INT_S3_SALES_DB;

CREATE OR REPLACE STAGE STG_S3_SALES_DB
URL = 's3://sales-dhaval-sf-1/'
STORAGE_INTEGRATION = int_s3_sales_db
FILE_FORMAT = (type = csv field_delimiter=',' skip_header=1);

LIST @STG_S3_SALES_DB;


COPY INTO SALES_DB.RAW_SCHEMA.ORDERS_RAW 
FROM @STG_S3_SALES_DB
FILE_FORMAT = (type = csv field_delimiter=',' skip_header=1);