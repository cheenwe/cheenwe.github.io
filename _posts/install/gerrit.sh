#  install gerrit


## 创建数据库

create database reviewdb;
use reviewdb;

CREATE TABLE account_group_by_id_aud (
added_by INT DEFAULT 0 NOT NULL,
removed_by INT,
removed_on TIMESTAMP NULL DEFAULT NULL,
group_id INT DEFAULT 0 NOT NULL,
include_uuid VARCHAR(255) BINARY DEFAULT '' NOT NULL,
added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,PRIMARY KEY(group_id,include_uuid,added_on)
);


CREATE TABLE account_group_members_audit (
added_by INT DEFAULT 0 NOT NULL,
removed_by INT,
removed_on TIMESTAMP NULL DEFAULT NULL,
account_id INT DEFAULT 0 NOT NULL,
group_id INT DEFAULT 0 NOT NULL,
added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,PRIMARY KEY(account_id,group_id,added_on)
);

CREATE TABLE changes (
change_key VARCHAR(60) BINARY DEFAULT '' NOT NULL,
created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
last_updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
sort_key VARCHAR(16) BINARY DEFAULT '' NOT NULL,
owner_account_id INT DEFAULT 0 NOT NULL,
dest_project_name VARCHAR(255) BINARY DEFAULT '' NOT NULL,
dest_branch_name VARCHAR(255) BINARY DEFAULT '' NOT NULL,
open CHAR(1) DEFAULT 'N' NOT NULL  CHECK (open IN ('Y','N')),
status CHAR(1) DEFAULT ' ' NOT NULL,
current_patch_set_id INT DEFAULT 0 NOT NULL,
subject VARCHAR(255) BINARY DEFAULT '' NOT NULL,
topic VARCHAR(255) BINARY,
last_sha1_merge_tested VARCHAR(40) BINARY,
mergeable CHAR(1) DEFAULT 'N' NOT NULL  CHECK (mergeable IN ('Y','N')),
row_version INT DEFAULT 0 NOT NULL,
change_id INT DEFAULT 0 NOT NULL
,PRIMARY KEY(change_id)
);
