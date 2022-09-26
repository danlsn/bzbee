library(tabulog)
library(rex)
library(magrittr)

log_file <- scan("/Users/danlsn/Documents/DATABASE/Backblaze/bzlogs/bzreports_lastfilestransmitted/2022-09-19.log", what = "character", sep = "\n")

parsed <- log_file %>%
  re_matches(
    rex(
      start,
      # Get Date of Log Entry
      capture(
        name = "datetime",
        regex(".{19}")
      ),
      " - ",
      # Line with Size, Throttle, Speed, Transfer Info
      maybe(
        one_or_more(space),
        capture(
          name = "size",
          regex("large|small")
        ),
        zero_or_more(space),
        " - ",
        maybe(
          "throttle ",
          maybe(
            "x",
            any_blanks,
            capture(
              name = "dedup",
              "dedup"
            ),
            " - "
          ),
          maybe(
            capture(
              name = "throttle_mode",
              any_alnums %>% at_least(2)
            ),
            one_or_more(space),
            capture(
              name = "throttle_level",
              any_alnums
            )
          )
        ),
        " - ",
        zero_or_more(space),
        capture(
          name = "upload_speed",
          any_digits
        ),
        space,
        capture(
          name = "speed_units",
          non_blanks
        ),
        " - ",
        capture(
          name = "bytes_transferred",
          any_digits
        ),
        maybe(" bytes ")
      ),
      maybe(any_blanks),
      maybe(
        capture(
          name = "batched_request",
          "Multiple",
          anything,
          end
        )
      ),
      maybe(
        "Chunk ",
        capture(
          name = "chunk_num",
          alnum %>% n_times(5)
        ),
        " of "
      ),
      maybe(
        "- ",
        capture(
          name = "file_path",
          anything,
          end
        )
      )
    )
  )

# 2022-09-18 23:59:44 -  large  - throttle manual   11 -  1384 kBits/sec - 10520933 bytes - Multiple small files batched in one request, the 3 files are listed below:
# 2022-09-18 23:59:44 -                                                                   - /Volumes/ProjectFS/Project-Library-2022/[835310] FGE—Werribee Zoo Secret Garden/A0_Originals/322ND750/DAN_3846.JPG
# 2022-09-18 23:59:44 -                                                                   - /Users/danlsn/.vscode/extensions/ms-python.python-2022.4.1/pythonFiles/lib/python/debugpy/_vendored/pydevd/pydevd_attach_to_process/inject_dll_amd64.pdb
# 2022-09-18 23:59:44 -                                                                   - /Volumes/MAISIE/PictureFSv2/_Inbox/AnyTrans/DCIM/2018-03-01/109APPLE/109APPLE_IMG_9604.JPG
