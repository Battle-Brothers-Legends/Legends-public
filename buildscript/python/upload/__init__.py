try:
	import requests
	import dacite
	import tqdm
except ImportError:
	print("Missing dependencies! Run: `pip install requests tqdm dacite`")
	exit(1)

from .client import *
from .nexus_upload_task import *
from .github_upload_task import *
