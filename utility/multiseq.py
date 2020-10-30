"""
Multiple Sequence Alignment
---

Code untuk membantu menyelesaikan soal 
multiple sequence alignment dengan 
menginput pivot sequence nya.

"""
import os
from pathlib import Path

os.chdir(Path(__file__).parent.absolute())

import numpy as np

def separator(cnt: int = 1):
    print("="* 14 * cnt, end="\n\n")

if __name__ == "__main__":
  with open("pairwise.txt", "r") as f:


