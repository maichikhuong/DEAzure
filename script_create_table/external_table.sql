-- Use the same file format as used for creating the External Tables during the LOAD step.
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
  CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
  WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
         FORMAT_OPTIONS (
           FIELD_TERMINATOR = ',',
           USE_TYPE_DEFAULT = FALSE
          ))
GO

-- Storage path where the result set will persist
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'DATA_EXTERNAL_SOURCE') 
  CREATE EXTERNAL DATA SOURCE [DATA_EXTERNAL_SOURCE] 
  WITH (
      LOCATION = 'abfss://adlsnycpayroll-yourfirstname-lastintial@storageaccountchikhuong.dfs.core.windows.net' 
  )
GO

CREATE EXTERNAL TABLE [dbo].[NYC_Payroll_Summary](
    [FiscalYear] [int] NULL,
    [AgencyName] [varchar](50) NULL,
    [TotalPaid] [float] NULL
)
WITH (
      LOCATION = '/dirstaging/',
    DATA_SOURCE = [DATA_EXTERNAL_SOURCE],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
GO

select * from [dbo].[NYC_Payroll_Summary]
GO

