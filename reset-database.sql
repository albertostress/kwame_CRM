-- Reset completo do banco de dados EspoCRM
-- Execute este SQL no MySQL se o instalador travar

USE espocrm;

-- Remove todas as tabelas do EspoCRM (se existirem)
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS action_history_record;
DROP TABLE IF EXISTS address_country;
DROP TABLE IF EXISTS admin_notification;
DROP TABLE IF EXISTS api_user;
DROP TABLE IF EXISTS array_value;
DROP TABLE IF EXISTS attachment;
DROP TABLE IF EXISTS audit;
DROP TABLE IF EXISTS authentication_provider;
DROP TABLE IF EXISTS auth_log_record;
DROP TABLE IF EXISTS auth_token;
DROP TABLE IF EXISTS auto_follow_record;
DROP TABLE IF EXISTS call;
DROP TABLE IF EXISTS campaign;
DROP TABLE IF EXISTS campaign_log_record;
DROP TABLE IF EXISTS campaign_tracking_url;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS dashboard_tab;
DROP TABLE IF EXISTS document;
DROP TABLE IF EXISTS document_folder;
DROP TABLE IF EXISTS document_lead;
DROP TABLE IF EXISTS email;
DROP TABLE IF EXISTS email_account;
DROP TABLE IF EXISTS email_address;
DROP TABLE IF EXISTS email_filter;
DROP TABLE IF EXISTS email_folder;
DROP TABLE IF EXISTS email_queue_item;
DROP TABLE IF EXISTS email_template;
DROP TABLE IF EXISTS entity_manager;
DROP TABLE IF EXISTS entity_team_user;
DROP TABLE IF EXISTS export;
DROP TABLE IF EXISTS extension;
DROP TABLE IF EXISTS external_account;
DROP TABLE IF EXISTS global_stream;
DROP TABLE IF EXISTS group_email_folder;
DROP TABLE IF EXISTS import;
DROP TABLE IF EXISTS import_entity;
DROP TABLE IF EXISTS import_error;
DROP TABLE IF EXISTS inbound_email;
DROP TABLE IF EXISTS integration;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS kanban_order;
DROP TABLE IF EXISTS knowledge_base_article;
DROP TABLE IF EXISTS knowledge_base_category;
DROP TABLE IF EXISTS last_viewed;
DROP TABLE IF EXISTS layout_record;
DROP TABLE IF EXISTS layout_set;
DROP TABLE IF EXISTS lead;
DROP TABLE IF EXISTS lead_capture;
DROP TABLE IF EXISTS lead_capture_log_record;
DROP TABLE IF EXISTS mass_email;
DROP TABLE IF EXISTS meeting;
DROP TABLE IF EXISTS note;
DROP TABLE IF EXISTS notification;
DROP TABLE IF EXISTS opportunity;
DROP TABLE IF EXISTS password_change_request;
DROP TABLE IF EXISTS phone_number;
DROP TABLE IF EXISTS portal;
DROP TABLE IF EXISTS portal_role;
DROP TABLE IF EXISTS portal_user;
DROP TABLE IF EXISTS preferences;
DROP TABLE IF EXISTS reminder;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS scheduled_job;
DROP TABLE IF EXISTS scheduled_job_log_record;
DROP TABLE IF EXISTS sms;
DROP TABLE IF EXISTS stream;
DROP TABLE IF EXISTS subscription;
DROP TABLE IF EXISTS target_list;
DROP TABLE IF EXISTS task;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS template;
DROP TABLE IF EXISTS two_factor_code;
DROP TABLE IF EXISTS unique_id;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS webhook;
DROP TABLE IF EXISTS webhook_queue_item;
DROP TABLE IF EXISTS working_time_calendar;
DROP TABLE IF EXISTS working_time_range;

SET FOREIGN_KEY_CHECKS = 1;

-- O banco está agora completamente limpo para instalação fresh