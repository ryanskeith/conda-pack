# Try to import conda_pack for version info
try:
    import conda_pack

    release = conda_pack.__version__
    version = ".".join(release.split(".")[:2])
except ImportError:
    # Fallback for when conda_pack is not available
    release = "unknown"
    version = "unknown"

# Project settings
project = 'conda-pack'
copyright = '2017, Jim Crist'
author = 'Jim Crist'

# Source file extensions
source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}

# Master document
master_doc = "index"
language = "en"
pygments_style = "sphinx"
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]

# Sphinx Extensions
extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.napoleon",
    "sphinx.ext.viewcode",
    "sphinx_rtd_theme",
    "myst_parser",
    "sphinx_copybutton",
]

# Napoleon settings
napoleon_google_docstring = True
napoleon_numpy_docstring = True
napoleon_include_init_with_doc = False
napoleon_include_private_with_doc = False
napoleon_include_special_with_doc = True
napoleon_use_admonition_for_examples = False
napoleon_use_admonition_for_notes = False
napoleon_use_admonition_for_references = False
napoleon_use_ivar = False
napoleon_use_param = True
napoleon_use_rtype = True
napoleon_use_keyword = True
napoleon_custom_sections = None

# Autodoc settings
autodoc_default_options = {
    "members": True,
    "member-order": "bysource",
    "special-members": "__init__",
    "undoc-members": True,
    "exclude-members": "__weakref__",
}
autodoc_typehints = "description"
autodoc_typehints_description_target = "documented"

# Intersphinx mapping (disabled for now)
intersphinx_mapping = {}

# Sphinx Theme
html_theme = "sphinx_rtd_theme"
html_theme_options = {
    "navigation_depth": 4,
    "collapse_navigation": False,
    "sticky_navigation": True,
    "includehidden": True,
    "titles_only": False,
    "display_version": True,
    "prev_next_buttons_location": "bottom",
    "style_external_links": True,
    "style_nav_header_background": "#2980B9",
}

# Templates and static files
templates_path = ['_templates']
html_static_path = ['_static']

# HTML output options
html_title = f"{project} {version}"
html_short_title = project
html_logo = None
html_favicon = None
html_use_index = True
html_split_index = False
html_show_sourcelink = True
html_show_sphinx = True
html_show_copyright = True

# Copy button settings
copybutton_prompt_text = r">>> |\.\.\. |\$ |In \[\d*\]: | {2,5}\.\.\.: | {5,8}: "  # noqa: E501
copybutton_prompt_is_regexp = True

# Open Graph settings (disabled for now)
# ogp_site_url = "https://conda.github.io/conda-pack/"
# ogp_image = "https://conda.github.io/conda-pack/_static/logo.png"
# ogp_description_length = 200
