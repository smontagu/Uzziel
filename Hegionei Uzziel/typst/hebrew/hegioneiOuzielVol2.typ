#import "macros.typ": *
#import "book.typ": *

#show: book.with(
  title: "הגיוני עזיאל",
  subtitle: "חלק ב",
  author: "הרב בן ציון מאיר חי עוזיאל",
  publicationDate:"תשי״ד",
  titlePageText: [
  מאת הראש״ל הרב הראשי לישראל הגאון הגדול מופה״ד\
מרן הרב רבי #text(size: 16pt)[ בן ציון מאיר חי עזיאל] זצוק״ל
בהרב הגאון הצדיק #larger[יוסף רפאל עזיאל] זצוק״ל\
    ראב״ד מקודש בעיקו״ת ירושצ״ו
  ],
  frontMatter: [
    #include "13.5-hakdama2.typ"
  ]
)

// Volume 2 starts from שער יד
#counter(heading).update(13)

#include "14-yira-ahava.typ"
#include "15-ahavat-tora.typ"
#include "16-devekut.typ"
#include "17-hashem-hu-haelohim.typ"
#include "18-misvot-vetakhlitan.typ"
#include "19-misvat-kedusha.typ"
#include "20-misvat-yira-veahava.typ"
#include "21-hakarat-hateuda.typ"
#include "22-haahava-bahaim.typ"
#include "23-ahavat-reim.typ"
#include "24-yemot-hamashiah.typ"
#include "25-haleumiut-veteudatah.typ"
#include "26-teudatenu-bahaim.typ"
#include "27-hasekhel-vehahefes.typ"
#include "28-hageula-veteudatah.typ"
#include "29-hahet-vehateshuva.typ"
#include "30-derakhim-baavoda.typ"
#include "31-briut-venekiut.typ"
#include "32-yehuda-halevi.typ"
