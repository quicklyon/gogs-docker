BRAND_NAME = "Gogs is a painless self-hosted Git service."
RUN_USER   = git
RUN_MODE   = prod

[database]
TYPE     = mysql
HOST     = {{MYSQL_HOST}}:{{MYSQL_PORT}}
NAME     = {{MYSQL_DB}}
USER     = {{MYSQL_USER}}
PASSWORD = {{MYSQL_PASSWORD}}
PATH     = /data/git/gogs.db

[repository]
ROOT = /data/git/repositories
FORCE_PRIVATE = {{GIT_FORCE_PRIVATE}}

[repository.upload]
TEMP_PATH = /data/git/tmp/uploads

[server]
DOMAIN           = {{APP_DOMAIN}}
HTTP_PORT        = 3000
EXTERNAL_URL     = {{APP_PROTOCOL}}://{{APP_DOMAIN}}
DISABLE_SSH      = true
SSH_PORT         = 2222
START_SSH_SERVER = false
OFFLINE_MODE     = true
ENABLE_GZIP 	 = true

APP_DATA_PATH    = /data/git/data

CERT_FILE 	 = /data/git/https/cert.pem
KEY_FILE 	 = /data/git/https/key.pem

[email]
ENABLED = {{MAIL_ENABLED}}
SUBJECT_PREFIX = `{{SMTP_SUBJECT_PREFIX}} `
HOST = {{SMTP_HOST}}:{{SMTP_PORT}}
FROM = `"{{SMTP_FROMNAME}}" <{{SMTP_USER}}>`
USER = {{SMTP_USER}}
PASSWORD = {{SMTP_PASS}}

DISABLE_HELO = {{MAIL_DISABLE_HELO}}
HELO_HOSTNAME = {{MAIL_HELO_HOST}}
SKIP_VERIFY = true

[service]
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL     = false
DISABLE_REGISTRATION   = true
ENABLE_CAPTCHA         = false
REQUIRE_SIGNIN_VIEW    = true

[picture]
AVATAR_UPLOAD_PATH 		= /data/git/avatars
REPOSITORY_AVATAR_UPLOAD_PATH 	= /data/git/repo-avatars
DISABLE_GRAVATAR        	= true
ENABLE_FEDERATED_AVATAR 	= false


[session]
PROVIDER = file
PROVIDER_CONFIG = /data/git/sessions


[log]
MODE      = console, file
LEVEL     = Info
ROOT_PATH = /data/git/log

[security]
INSTALL_LOCK = true
SECRET_KEY   = {{SECRET_KEY}}


[lfs]
STORAGE = local
OBJECTS_PATH = /data/git/lfs-objects

[attachment]
ENABLED = true
PATH = /data/git/data/attachments
ALLOWED_TYPES = image/jpeg|image/png
MAX_SIZE = 4
MAX_FILES = 5

[other]
SHOW_FOOTER_BRANDING = false
SHOW_FOOTER_TEMPLATE_LOAD_TIME = false
