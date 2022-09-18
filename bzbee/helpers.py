from xml.etree import ElementTree as ET
import typing
from models import BzVolume


def get_remaining_backup() -> list:
    tree = ET.parse("../data/in/bzreports/bzstat_remainingbackup.xml")
    root = tree.getroot()
    contents = [node.attrib for node in root.iter("bzvolume")]

    contents_new = []
    for node in root.iter("bzvolume"):
        contents_new.append(node.attrib)

    return contents


def get_volumes() -> list:
    tree = ET.parse("../data/in/bzinfo.xml")
    root = tree.getroot()
    bz_vols = [
        node.attrib for node in root.findall("./hard_drives_to_backup/")
    ]
    return bz_vols


def get_total_backup() -> list:
    tree = ET.parse("../data/in/bzreports/bzstat_totalbackup.xml")
    root = tree.getroot()
    total_backup = [node.attrib for node in root.findall("bzvolume")]
    return total_backup


def get_bz_defcon() -> list:
    tree = ET.parse("../data/in/bzreports/bzdefcon.xml")
    root = tree.getroot()
    bz_defcon = [node.attrib for node in root.findall("bzvolume")]
    return bz_defcon


def get_all_volume_stats() -> list:
    all_stats = []
    [all_stats.append(item) for item in get_remaining_backup()]
    [all_stats.append(item) for item in get_volumes()]
    [all_stats.append(item) for item in get_bz_defcon()]
    [all_stats.append(item) for item in get_total_backup()]
    res = parse_bz_vol_list(all_stats)
    return res


def parse_bz_vol_list(volumes_list: list) -> dict[dict]:
    output = {}
    for line in volumes_list:
        try:
            guid = line["bzVolumeGuid"]
            if not guid in output:
                output[guid] = {}
            for k, v in line.items():
                output[guid][k] = v

        except KeyError:
            print("No key here boss!")
    return output


def main():
    """
    {
        '{bzvolumeid}': { attrs },
        '{bzvolumeid}': { attrs }...
    }
    :return:
    """

    """
   {
       'v0008f0062df449b01337cd30611': {
            'pervol_sel_for_backup_numfiles': '617859',
            'pervol_sel_for_backup_numbytes': '86666888951
            }
       }
   :return:
   """
    all_stats = get_all_volume_stats()
    print(all_stats["v0008f0062df449b01337cd30611"])
    bz_vol = BzVolume(all_stats["v0008f0062df449b01337cd30611"])
    pass


if __name__ == "__main__":
    main()
