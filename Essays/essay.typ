#import "macros.typ": *

#let firstFootnote(body) = {
  footnote(numbering: _ => [\*])[#body]
  counter(footnote).update(n => n - 1)
}

#let essay(title: "",
          author: "",
          subtitle: "",
          citation: "",
          content) = {

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
    first-line-indent: 0em
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

  // Main matter
  content
}
