from dataclasses import dataclass
from typing import Union
from pathlib import Path


@dataclass
class BzVolume:
    guid: str
    mount_point: Union[str, Path]
    mount_hex: str
    defcon_lvl: int
    last_seen: int
    last_filelist: int
    last_push: int
    files_selected: int
    files_remaining: int
    files_selected_bytes: int
    files_remaining_bytes: int

    def __init__(self, bz_v):
        self.guid = bz_v['bzVolumeGuid']
        self.mount_point = bz_v['mountPointPath']
        self.mount_hex = bz_v['mountPointPathHex']
        self.defcon_lvl = int(bz_v['vol_defcon_level'])
        self.last_seen = int(bz_v['vol_last_seen_in_days'])
        self.last_filelist = int(bz_v['vol_last_filelisted_in_days'])
        self.last_push = int(bz_v['vol_last_file_pushed_in_days'])
        self.files_selected = int(bz_v['pervol_sel_for_backup_numfiles'])
        self.files_remaining = int(bz_v['pervol_remaining_files_numfiles'])
        self.files_selected_bytes = int(bz_v['pervol_sel_for_backup_numfiles'])
        self.files_remaining_bytes = int(bz_v['pervol_remaining_files_numbytes'])



