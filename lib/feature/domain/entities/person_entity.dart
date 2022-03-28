class PersonEntity {
  final int? id;
  final String? name, status, species, type, gender, image;
  final LocationEntity? origin, location;
  final List<String>? episode;
  final DateTime? created;

  const PersonEntity({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
    this.origin,
    this.location,
    this.episode,
    this.created,
  });
}

class LocationEntity {
  final String? name, url;

  const LocationEntity(this.name, this.url);
}
