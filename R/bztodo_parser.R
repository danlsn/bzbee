library(rex)
library(magrittr)

bz_todo_log <- scan(file = "/Library/Backblaze.bzpkg/bzdata/bzbackup/bzdatacenter/bz_todo_20220924_0.dat", what = "character", sep = "\n")

bz_todo_parsed <- bz_todo_log %>%
  re_matches(
    rex(
      start,
      capture(
        name = "line_version",
        digit
      ),
      space,
      capture(
        name = "instruction",
        print
      ),
      space,
      capture(
        name = "filename_id",
        print %>% n_times(16)
      ),
      space,
      capture(
        name = "mod_time_millis",
        print %>% n_times(16)
      ),
      space,
      capture(
        name = "filesize_bytes",
        digits
      ),
      space,
      capture(
        name = "filename",
        anything
      ),
      end
    )
  )
