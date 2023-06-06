class BookResModel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  BookResModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BookResModel.fromJson(Map<String, dynamic> json) => BookResModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  List<Author> authors;
  List<String> bookshelves;
  int downloadCount;
  Formats formats;
  List<String> languages;
  String? mediaType;
  List<String> subjects;
  String title;

  Result({
    required this.id,
    required this.authors,
    required this.bookshelves,
    required this.downloadCount,
    required this.formats,
    required this.languages,
    required this.mediaType,
    required this.subjects,
    required this.title,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
        downloadCount: json["download_count"],
        formats: Formats.fromJson(json["formats"]),
        languages: json["languages"] != null
            ? List<String>.from(json["languages"])
            : [],
        mediaType: json["media_type"],
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "download_count": downloadCount,
        "formats": formats.toJson(),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "media_type": mediaType,
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "title": title,
      };
}

class Author {
  int? birthYear;
  int? deathYear;
  String name;

  Author({
    this.birthYear,
    this.deathYear,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "birth_year": birthYear,
        "death_year": deathYear,
        "name": name,
      };
}

class Formats {
  String? applicationXMobipocketEbook;
  String? applicationPdf;
  String? textPlainCharsetUsAscii;
  String? textPlainCharsetUtf8;
  String applicationRdfXml;
  String? applicationZip;
  String? applicationEpubZip;
  String? textHtmlCharsetUtf8;
  String? textHtml;
  String? textPlain;
  String? textPlainCharsetIso88591;
  String? audioOgg;
  String? audioMp4;
  String? audioMpeg;
  String? imageJpeg;
  String? textHtmlCharsetIso88591;

  Formats({
    this.applicationXMobipocketEbook,
    this.applicationPdf,
    this.textPlainCharsetUsAscii,
    this.textPlainCharsetUtf8,
    required this.applicationRdfXml,
    this.applicationZip,
    this.applicationEpubZip,
    this.textHtmlCharsetUtf8,
    this.textHtml,
    this.textPlain,
    this.textPlainCharsetIso88591,
    this.audioOgg,
    this.audioMp4,
    this.audioMpeg,
    this.imageJpeg,
    this.textHtmlCharsetIso88591,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationPdf: json["application/pdf"],
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
        textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
        applicationRdfXml: json["application/rdf+xml"],
        applicationZip: json["application/zip"],
        applicationEpubZip: json["application/epub+zip"],
        textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
        textHtml: json["text/html"],
        textPlain: json["text/plain"],
        textPlainCharsetIso88591: json["text/plain; charset=iso-8859-1"],
        audioOgg: json["audio/ogg"],
        audioMp4: json["audio/mp4"],
        audioMpeg: json["audio/mpeg"],
        imageJpeg: json["image/jpeg"],
        textHtmlCharsetIso88591: json["text/html; charset=iso-8859-1"],
      );

  Map<String, dynamic> toJson() => {
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/pdf": applicationPdf,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
        "text/plain; charset=utf-8": textPlainCharsetUtf8,
        "application/rdf+xml": applicationRdfXml,
        "application/zip": applicationZip,
        "application/epub+zip": applicationEpubZip,
        "text/html; charset=utf-8": textHtmlCharsetUtf8,
        "text/html": textHtml,
        "text/plain": textPlain,
        "text/plain; charset=iso-8859-1": textPlainCharsetIso88591,
        "audio/ogg": audioOgg,
        "audio/mp4": audioMp4,
        "audio/mpeg": audioMpeg,
        "image/jpeg": imageJpeg,
        "text/html; charset=iso-8859-1": textHtmlCharsetIso88591,
      };
}

// enum MediaType { TEXT, SOUND }
//
// final mediaTypeValues =
//     EnumValues({"Sound": MediaType.SOUND, "Text": MediaType.TEXT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
