from pathlib import Path

from docx import Document
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.shared import Inches, Pt


OUT = Path("hello_world_flutter_submission_description.docx")
SCREENSHOT_DIR = Path("screenshots")


def set_run_font(run, size=11, bold=False):
    run.font.name = "Calibri"
    run._element.rPr.rFonts.set(qn("w:eastAsia"), "Calibri")
    run.font.size = Pt(size)
    run.bold = bold


def add_paragraph(doc, text):
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(6)
    p.paragraph_format.line_spacing = 1.1
    run = p.add_run(text)
    set_run_font(run)
    return p


def add_heading(doc, text, size=14):
    p = doc.add_paragraph()
    p.paragraph_format.space_before = Pt(10)
    p.paragraph_format.space_after = Pt(4)
    run = p.add_run(text)
    set_run_font(run, size=size, bold=True)
    return p


def build_doc():
    doc = Document()
    section = doc.sections[0]
    section.top_margin = Inches(1)
    section.bottom_margin = Inches(1)
    section.left_margin = Inches(1)
    section.right_margin = Inches(1)

    normal = doc.styles["Normal"]
    normal.font.name = "Calibri"
    normal._element.rPr.rFonts.set(qn("w:eastAsia"), "Calibri")
    normal.font.size = Pt(11)

    title = doc.add_paragraph()
    title.alignment = WD_ALIGN_PARAGRAPH.CENTER
    title.paragraph_format.space_after = Pt(10)
    run = title.add_run("Hello World Flutter App Lab")
    set_run_font(run, size=18, bold=True)

    add_heading(doc, "Brief Description")
    add_paragraph(
        doc,
        "I used the Flutter SDK installed at /Users/parasgandhi/Project/temp/flutter "
        "to create a new Flutter project named hello_world_flutter_app. After the "
        "project was generated, I updated lib/main.dart to replace the default "
        "counter template with a simple Material app that displays a centered "
        "Hello World message under a Flutter Lab app bar.",
    )
    add_paragraph(
        doc,
        "I verified the project by running flutter analyze, flutter test, and "
        "flutter build web. The app was then opened from a local build in the "
        "browser and screenshots were captured to show the tested output. The "
        "current machine does not have an Android SDK installed, and full Xcode "
        "is not selected, so Android or iOS simulator execution is blocked until "
        "one of those simulator environments is configured.",
    )

    add_heading(doc, "Screenshots")
    for label, image_name, width in [
        ("Chrome test target", "hello_world_flutter_app_chrome.png", 5.9),
        ("Mobile-sized browser viewport", "hello_world_flutter_app_mobile_view.png", 2.3),
    ]:
        image_path = SCREENSHOT_DIR / image_name
        if image_path.exists():
            caption = doc.add_paragraph()
            caption.paragraph_format.space_before = Pt(6)
            caption.paragraph_format.space_after = Pt(4)
            cap_run = caption.add_run(label)
            set_run_font(cap_run, bold=True)
            picture = doc.add_picture(str(image_path), width=Inches(width))
            picture._inline.docPr.set("descr", f"{label} showing the Hello World Flutter app.")
            picture._inline.docPr.set("title", label)

    doc.save(OUT)
    print(f"wrote {OUT.resolve()}")


if __name__ == "__main__":
    build_doc()
