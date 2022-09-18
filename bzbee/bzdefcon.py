import xml.etree.ElementTree as ET
import pandas as pd


TEST_XML = "/Users/danlsn/Documents/Projects/IdeaProjects/bzbee/data/in/bzreports/bzdefcon.xml"


class BzDefcon:
    pass


def main():
    with open(TEST_XML, 'r') as f:
        tree = ET.parse(f)
        root = tree.getroot()
        children = [c.attrib for c in root if c.tag == 'bzvolume']

    df = pd.DataFrame(children)
    df.set_index('bzVolumeGuid', inplace=True)
    df['mountPointPath'] = df[['mountPointPathHex']].applymap(lambda x: bytes.fromhex(x).decode("ASCII"))

    pass


if __name__ == "__main__":
    main()
