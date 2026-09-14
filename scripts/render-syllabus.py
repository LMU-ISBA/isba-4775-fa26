# /// script
# requires-python = ">=3.10"
# dependencies = ["Markdown>=3.7,<4", "weasyprint>=65,<70"]
# ///
"""Render the syllabus Markdown as a Letter-sized PDF with repeating table headers."""
from pathlib import Path

import markdown
from weasyprint import HTML

ROOT = Path(__file__).resolve().parents[1]
CSS = """
@page {
  size: Letter;
  margin: .65in .7in .65in;
  @bottom-center {
    content: "Page " counter(page) " of " counter(pages);
    font: 9pt Arial, sans-serif;
    color: #555;
  }
}
body { font: 10pt/1.38 Arial, sans-serif; color: #222; }
h1 { font-size: 19pt; line-height: 1.2; margin: 0 0 16pt; }
h2 { font-size: 13pt; margin: 17pt 0 8pt; border-bottom: 1px solid #ddd;
     padding-bottom: 4pt; }
h3 { font-size: 11.5pt; margin: 13pt 0 6pt; }
h1, h2, h3 { break-after: avoid; }
p { margin: 0 0 8pt; orphans: 3; widows: 3; }
a { color: #245b8f; text-decoration: none; overflow-wrap: anywhere; }
table { width: 100%; border-collapse: collapse; margin: 9pt 0 12pt;
        font-size: 9pt; line-height: 1.35; }
thead { display: table-header-group; }
th, td { border: 1px solid #ccc; padding: 4pt 6pt; vertical-align: top;
         overflow-wrap: normal; }
th { background: #f3f3f3; text-align: left; }
tr { break-inside: avoid; }
ul, ol { margin: 5pt 0 10pt; padding-left: 20pt; }
li { margin-bottom: 4pt; }
code { font-family: monospace; font-size: .9em; overflow-wrap: anywhere; }
pre { white-space: pre-wrap; }
"""


def main():
    body = markdown.markdown(
        (ROOT / "syllabus.md").read_text(), extensions=["tables", "fenced_code"]
    )
    html = (
        '<!doctype html><html lang="en"><head><meta charset="utf-8">'
        '<title>ISBA 4775 - Fall 2026 Syllabus</title>'
        f"<style>{CSS}</style></head><body>{body}</body></html>"
    )
    output = ROOT / "isba-4775-syllabus-fa26.pdf"
    HTML(string=html, base_url=str(ROOT)).write_pdf(output)
    print(output)


if __name__ == "__main__":
    main()
