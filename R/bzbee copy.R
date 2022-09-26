library(tidyverse)

LAST_FILE_TRANSMITTED = "/Library/Backblaze.bzpkg/bzdata/bzlogs/bzreports_lastfilestransmitted/19.log"
BZ_DONE = "/Library/Backblaze.bzpkg/bzdata/bzbackup/bzdatacenter/bz_done_20220919_0.dat"

bz_done_log <- read.delim(BZ_DONE, header = FALSE)
