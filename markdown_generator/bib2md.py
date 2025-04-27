import bibtexparser
import argparse
import os

def format_markdown_entry(entry, highlight_author=None):
    title = entry.get('title', 'No Title').strip('{}').replace('\n', ' ').replace('\r', ' ')

    # Clean and process authors
    raw_authors = entry.get('author', 'No Authors').replace('\n', ' ').replace('\r', ' ')
    authors = raw_authors.replace(' and ', ', ').split(', ')

    # Bold the highlighted author if provided
    if highlight_author:
        authors = [f"**{author}**" if highlight_author.lower() in author.lower() else author for author in authors]

    authors_line = ', '.join(authors)
    venue = entry.get('booktitle', entry.get('journal', 'Unknown Venue')).replace('\n', ' ').replace('\r', ' ')
    return f"- **{title}**<br> {authors_line}<br> *{venue}*"

def filter_and_convert_bibtex_to_markdown(input_bib_file, highlight_author=None):
    with open(input_bib_file, 'r', encoding='utf-8') as bibtex_file:
        bib_database = bibtexparser.load(bibtex_file)

    non_arxiv_entries = [
        entry for entry in bib_database.entries
        if entry.get('journal', '').strip().lower() != 'corr'
    ]

    conference_entries = [entry for entry in non_arxiv_entries if entry.get('ENTRYTYPE') == 'inproceedings']
    journal_entries = [entry for entry in non_arxiv_entries if entry.get('ENTRYTYPE') == 'article']

    # Markdown content
    lines = [
        "---",
        'title: "Publications"',
        "permalink: /pubs/",
        "author_profile: true",
        "---",
        "",
        "# Publications",
        ""
    ]

    if conference_entries:
        lines.append("## Conference Papers\n")
        for entry in conference_entries:
            lines.append(format_markdown_entry(entry, highlight_author))
        lines.append("")

    if journal_entries:
        lines.append("## Journal Papers\n")
        for entry in journal_entries:
            lines.append(format_markdown_entry(entry, highlight_author))
        lines.append("")

    output_md_file = "../_pages/pubs.md"
    os.makedirs(os.path.dirname(output_md_file), exist_ok=True)

    with open(output_md_file, 'w', encoding='utf-8') as md_file:
        md_file.write('\n'.join(lines))

    print(f"Markdown publication list saved to {output_md_file}")

def main():
    parser = argparse.ArgumentParser(description="Convert a .bib file to a markdown publication list, excluding ArXiv papers.")
    parser.add_argument('input_bib', type=str, help='Path to the input .bib file')

    args = parser.parse_args()
    input_bib = args.input_bib
    highlight_author = "Debasis Ganguly"

    filter_and_convert_bibtex_to_markdown(input_bib, highlight_author)

if __name__ == "__main__":
    main()

