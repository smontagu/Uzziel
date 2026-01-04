#import "macros.typ": *

#let book(title: "",
          author: "",
          subtitle: "",
          publicationDate: "",
          frontMatter: "",
          mainMatter) = {

 set document(
     title: title + " " + subtitle,
     author: author
 )

 set page(
     paper: "a5",
     margin: (inside:  2cm,
         outside: 2.5cm,
         top:     2.5cm,
         bottom:  2.5cm),
 )

 set par(
     justify: true,
     leading: 0.65em,
     spacing: 0.95em,
     first-line-indent: 2em
 )

 set text(
     size: 11pt,
     font: "Brill"
 )

 show footnote.entry: it => {
     let gap = 1em
     let nums = counter(footnote).at(it.note.location())
     let number = numbering(it.note.numbering, ..nums)
     let link = link.with(it.note.location())
     grid(columns: (1.5em, 1fr), link(number), it.note.body)
 }

 //format headings in front matter
 show heading.where(
  level: 1
 ): it => {
  text(
    size: 16pt,
    weight: "bold",
    it.body
  )
 }
 show heading.where(
   level: 2
 ): it => {
  pagebreak(to: "odd")
  text(
    size: 16pt,
    weight: "bold",
    it.body
  )
 }

 show heading.where(
  level: 3
 ): it => {
   block( // make this a block element so that the first paragraph has no indent
      text(weight: "bold",
           size: 12pt,
             it.body)
   )
   v(1em)
 }

 set outline(indent: 1em)
 show outline.entry.where(
  level: 1
 ): it => {
   block(above: 1.2em)
        [#link(it.element.location(),
              it.indented(text(weight: "bold",
                               size: 12pt,
                               [#it.prefix():]),
                          text(weight: "regular",
                               size: 10pt,
                               it.inner())))]
 }

 show outline.entry.where(
  level: 2
 ): it => {
   let header = ""
   if it.prefix() != none {
    header = [#it.prefix():]
  }
   block(above: 0.1em)
       [#link(it.element.location(),
              it.indented(text(size: 10pt, header),
                          text(size: 10pt, it.inner())))]
 }

 
 // Front matter
 // half title page
 [
   #set align(center)
   #v(3em)
   #text(weight: "bold", size:20pt)[#title]
   #v(3em)
   #text(weight: "bold", size:16pt)[#subtitle]
   #v(3em)
   #text(weight: "bold", size:16pt)[#author]

   #pagebreak(to: "odd")

   // title page
   #set align(right)
   ב״ה
   #set align(center)
   #text(size: 10pt)[ספר]
   #text(size: 28pt)[_#title _]

   #text(size: 20pt)[#subtitle]
   #v(.5em)
   מחקרים והגות לב בידוסות האמונה של תורת ישראל מפי
   אלקים חיים, נובעים מדברי רז״ל בתלמודם ומדרשם, ומפי מאורינו ומורינו
   הגדולים החוקרים על דבר אמת, ערוכים ומסודרים לשערים ופרקים

   #v(1.5em)

ממני הצערי באלפי ישראל

   #text(size: 12pt)[ בן ציון מאיר חי עזיאל]

  בן לאדוני אבי עטרת ראשי הודי והדרי זצוק״ל\ 
  הגאון הצדיק #larger[יוסף רפאל עזיאל] זצוק״ל\
  ראב״ד מקודש בעיקו״ת ירושצ״ו

   #v(1.5em)
    פעיה״ק #larger[ירושלים] ת״ו\ 
    שנת #larger[#publicationDate] לפ״ק

   #v(1.5em)
   יו״ל שנית פעיה״ק #larger[ירושלים] ת״ו\ 
   שנת #larger[תשפ״ה] לפ״ק\ 
   על ידי הוצאות חטף סגול\ 
   #v(.5em)
   #image("hatafSegolLogoNoText.png", width: 16mm)
   באמצעות Typst

   #pagebreak(to: "odd")
   #counter(page).update(1)

  ]

  // code to suppress headers on empty pages copied from
  // https://forum.typst.app/t/how-can-i-suppress-headers-and-footers-on-blank-verso-trailing-pages/4384/2

  let is-page-empty() = {
    let page-num = here().page()
    query(selector.or(<ep-start>, <ep-end>))
      .chunks(2)
      .any(((start, end)) => {
        start.location().page() < page-num and page-num < end.location().page()
      })
  }

  show pagebreak: it => [#metadata[]<ep-start>] + it + [#metadata[]<ep-end>]

  // headers in front matter
  set page(
    header: context if not is-page-empty() {
      let thisPage = here().page()
      if calc.even(thisPage) { // even page
        counter(page).display()
        h(1fr)
      } else {
        h(1fr)
        counter(page).display()
      }
      line(length: 100%)
    },
    footer: {
    }
  )

  outline(depth: 2)

  // headers in foreword and main matter
  set page(
    numbering: "1",

    header: context if not is-page-empty() {
    let thisPage = here().page()

    // No heading if this page is a part title
    let nextPart = query(heading.where(level: 1).after(here()))
    if nextPart.len() > 0 and nextPart.first().location().page() == thisPage {
       return
    }

    // No heading if this page is a chapter title
    let nextChapter = query(heading.where(level: 2).after(here()))
    if nextChapter.len() > 0 and nextChapter.first().location().page() == thisPage {
       return
    }

    let partTitle = title
    let chapterTitle = ""

    let lastPart = query(heading.where(level: 1).before(here()))
    // this is a hack to avoid using the title "תוכן עניינים" before the
    // first part
    if lastPart != () and lastPart.first() != lastPart.last(){
       partTitle = lastPart.last().body
    }

    let lastChapter = query(heading.where(level: 2).before(here()))
    if lastChapter != () {
       chapterTitle = lastChapter.last().body
    }

    if calc.even(thisPage) { // even page
       counter(page).display()
       h(1fr)
       partTitle
    } else {
       chapterTitle
       h(1fr)
       counter(page).display()
    }
    line(length: 100%)
  },
  footer: context if not is-page-empty() {
    let thisPage = here().page()

    // On chapter title pages, centered page number in the footer
    let lastHeading = query(heading.where(level: 2).before(here()))
    if lastHeading != () and lastHeading.last().location().page() == thisPage {
       align(center)[#counter(page).display()]
    }
  }
 )
 frontMatter

 // Main matter

 set heading(numbering: (..nums) => {
   // We want the positional arguments
   // from `nums`.
   // `numbers` is now an array of ints
   // e.g. a level one heading `= ...`  could be (1,)
   // e.g. a level two heading `== ...` could be (2, 1)
   // e.g. a level three heading `=== ...` could be (1, 0, 2)
   let numbers = nums.pos()
   // Top level (level 1) headings will have a single
   // int like (1,), as mentioned above. So we check
   // if the array's length is 1 for level one headings.
   if numbers.len() == 1 {
       [Part #numbering("1", ..numbers)]
   } else if numbers.len() == 2 {
       [Chapter #numbering("1", numbers.last())]
   } else {
      // Everything else
      none
   }
 })

 show heading.where(
  level: 1
 ): it => {
   pagebreak(to: "odd")
   set align(center)
   v(8em)
   text(weight: "bold",
        size: 20pt,
        counter(heading).display())
   v(1.5em)
   text(weight: "bold",
        size: 24pt,
        it.body)
   pagebreak(to: "odd")
 }

 show heading.where(
  level: 2
 ): it => {
   pagebreak(weak: true)
   set align(center)
   text(weight: "bold",
        size: 12pt,
        counter(heading).display())
   v(1em)
   block( // make this a block element so that the first paragraph has no indent
      text(weight: "bold",
           size: 14pt,
             it.body)
   )
   v(1.5em)
 }

 show heading.where(
  level: 3
 ): it => {
   block( // make this a block element so that the first paragraph has no indent
      text(weight: "bold",
           size: 12pt,
             it.body)
   )
   v(1em)
 }

 counter(page).update(1)

 mainMatter
}
