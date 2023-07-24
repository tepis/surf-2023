enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  final allMachineries = getAllMachineries(mapBefore2010.values.toList() + mapAfter2010.values.toList());
  final sortedAges = getSortedAges(allMachineries);
  final averageAge = calculateAverageAge(sortedAges);
  final oldestHalfAverageAge = calculateOldestHalfAverageAge(sortedAges);

  print('Средний возраст всей техники: $averageAge');
  print('Средний возраст 50% самой старой техники: $oldestHalfAverageAge');
}

List<AgriculturalMachinery> getAllMachineries(List<List<Territory>> territories) {
  List<AgriculturalMachinery> list = territories.expand(
    (territories) => territories.expand(
      (territory) => territory.machineries
    ).toList()
  ).toList();
  
  return unique(list);
}

List<AgriculturalMachinery> unique(List<AgriculturalMachinery> list) {
  Set<AgriculturalMachinery> s = Set.from(list);
  return s.toList();
}


List<int> getSortedAges(List<AgriculturalMachinery> machineries) {
  final now = DateTime.now();
  List<int> ages = machineries.map((machinery) => now.year - machinery.releaseDate.year).toList();
  ages.sort();
  
  return List.from(ages.reversed);
}
  
double calculateAverageAge(List<int> ages) {
  return ages.reduce((accum, value) => accum + value) / ages.length;
}

double calculateOldestHalfAverageAge(List<int> ages) {
  List<int> half = ages.sublist(0, ages.length ~/ 2);
  return half.reduce((accum, value) => accum + value) / half.length;
}