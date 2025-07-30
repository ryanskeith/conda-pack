try:
    from . import _version

    __version__ = _version.__version__
except ImportError:
    __version__ = "unknown"

# Import main functionality
from .core import CondaEnv, CondaPackException, File, pack

__all__ = ["CondaEnv", "CondaPackException", "File", "pack", "__version__"]
