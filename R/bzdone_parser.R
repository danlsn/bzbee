library(rex)
library(magrittr)

bz_done_file <- scan(file = "/Library/Backblaze.bzpkg/bzdata/bzbackup/bzdatacenter/bz_done_20220923_0.dat", what = "character", sep = "\n")

bz_done_parsed <- bz_done_file %>%
  re_matches(
    rex(
      # START
      start,
      # Col 0: Line Version
      capture(
        name = "line_version",
        number
      ),
      space,
      # Col 1: Instruction
      capture(
        name = "instruction",
        print
      ),
      space,
      # Col 2: Flags
      capture(
        name = "flags",
        print %>% n_times(3)
      ),
      space,
      # Col 3: DateTime of Instruction
      capture(
        name = "date_time",
        digit %>% n_times(14)
      ),
      space,
      # Col 4: BzLongFileId
      capture(
        name = "bz_long_file_id",
        print %>% n_times(83)
      ),
      space,
      # Col 5: Uploaded Member Pod,
      capture(
        name = "member_pod",
        print %>% n_times(3)
      ),
      space,
      # Col 6: FileNameId
      capture(
        name = "filename_id",
        alnum %>% n_times(16)
      ),
      space,
      # Col 7: ChunkType_SequenceNum
      capture(
        name = "chunk_type_seqnum",
        print %>% n_times(9)
      ),
      space,
      # Col 8: SHA-1
      capture(
        name = "sha_1",
        print %>% n_times(40)
      ),
      space,
      # Col 9: CreateTimeMillis
      capture(
        name = "create_time_millis",
        print %>% n_times(16)
      ),
      space,
      # Col 10: ModTimeMillis
      capture(
        name = "mod_time_millis",
        print %>% n_times(16)
      ),
      space,
      # Col 11: ChunkFileId
      capture(
        name = "chunk_file_id",
        print %>% between(1, 18)
      ),
      space,
      # Col 12: FileSizeInBytes
      capture(
        name = "filesize_bytes",
        digits
      ),
      space,
      # Col 13: FileName
      capture(
        name = "filename",
        anything
      ),
      # END
      end
    )
  )

str(parsed)
