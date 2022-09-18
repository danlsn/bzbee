import xml.etree.ElementTree as ET
from collections import defaultdict

import pandas as pd

TEST_XML = "/Library/Backblaze.bzpkg/bzdata/bzreports/bzstat_totalbackup.xml"


def _parse_bzvolumes(xml_path):
    with open(xml_path, "r") as f:
        tree = ET.parse(f)
    root = tree.getroot()
    bzvols = [c.attrib for c in root if c.tag == "bzvolume"]
    return bzvols


class BzParser:
    def __init__(
        self, xml_path="/Library/Backblaze.bzpkg/bzdata/bzvolumes.xml"
    ):
        self.xml_path = xml_path
        self.bzvols = _parse_bzvolumes(self.xml_path)
        self.xmls = [
            "/Library/Backblaze.bzpkg/bzdata/bzvolumes.xml",
            "/Library/Backblaze.bzpkg/bzdata/bzreports/bzstat_remainingbackup.xml",
            "/Library/Backblaze.bzpkg/bzdata/bzreports/bzstat_totalbackup.xml",
            "/Library/Backblaze.bzpkg/bzdata/bzreports/bzdefcon.xml"
        ]

    def update(self):
        for x in self.xmls:
            self.bzvols = self.parse(x)
        return

    def parse(self, xml_path):
        d = defaultdict(dict)
        bzvols = _parse_bzvolumes(xml_path)
        for l in (bzvols, self.bzvols):
            for elem in l:
                d[elem["bzVolumeGuid"]].update(elem)
        self.bzvols = d.values()
        return self.bzvols

    def to_list(self):
        return self.bzvols

    def to_df(self):
        self.update()
        bzvols_df = pd.DataFrame(self.bzvols)
        bzvols_df.set_index("bzVolumeGuid", inplace=True)
        bzvols_df["mountPointPath"] = bzvols_df[
            ["mountPointPathHex"]
        ].applymap(lambda x: bytes.fromhex(x).decode("ASCII"))
        # df.dropna(inplace=True)
        bzvols_df = bzvols_df.astype(
            {
                "pervol_sel_for_backup_numfiles": "Int64",
                "pervol_sel_for_backup_numbytes": "Int64",
                "vol_defcon_level": "Int64",
                "vol_last_seen_in_days": "Int64",
                "vol_last_filelisted_in_days": "Int64",
                "vol_last_file_pushed_in_days": "Int64",
                "pervol_remaining_files_numfiles": "Int64",
                "pervol_remaining_files_numbytes": "Int64",
                "numBytesFreeOnVolume": "Int64",
                "numBytesUsedOnVolume": "Int64",
                "numBytesTotalOnVolume": "Int64",
            }
        )
        bzvols_df["lastTimeVolumeWasSeenAttachedGmtMillis"] = pd.to_datetime(
            bzvols_df["lastTimeVolumeWasSeenAttachedGmtMillis"], unit="ms"
        )

        return bzvols_df


if __name__ == "__main__":
    bz = BzParser()
    df = bz.to_df()

    print(df.dtypes)
    pass
