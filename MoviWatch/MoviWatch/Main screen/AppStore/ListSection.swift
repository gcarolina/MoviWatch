//
//  ListSection.swift
//  MoviWatch
//
//  Created by Carolina on 31.03.23.
//

import Foundation

struct ListCellModel {
    let kinopoiskId: Int
    let title: String
    let image: String
}

enum ListSection {
    case thriller([ListCellModel])
        case drama([ListCellModel])
        case crime([ListCellModel])
        case melodrama([ListCellModel])
        case detective([ListCellModel])
        case fantasy([ListCellModel])
    
    var items: [ListCellModel] {
        switch self {
        case .thriller(let items),
                .drama(let items),
                .crime(let items),
                .melodrama(let items),
                .detective(let items),
                .fantasy(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .thriller:
            return "Триллер"
        case .drama:
            return "Драма"
        case .crime:
            return "Криминал"
        case .melodrama:
            return "Мелодрама"
        case .detective:
            return "Детектив"
        case .fantasy:
            return "Фентези"
        }
    }
}

struct FilmsForGenres {
    static let shared = FilmsForGenres()

    private let thrillers: ListSection = {
        .thriller([.init(kinopoiskId: 447301, title: "Начало", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/447301.jpg"),
                  .init(kinopoiskId: 632602, title: "Призрак оперы в Королевском Алберт-холле", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/632602.jpg"),
                  .init(kinopoiskId: 389, title: "Леон", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/389.jpg"),
                  .init(kinopoiskId: 361, title: "Бойцовский клуб", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/361.jpg"),
                  .init(kinopoiskId: 397667, title: "Остров проклятых", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/397667.jpg"),
                  .init(kinopoiskId: 3797, title: "Адвокат дьявола", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/3797.jpg"),
                  .init(kinopoiskId: 1991, title: "Привидение", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/1991.jpg"),
                  .init(kinopoiskId: 71053, title: "Любовь без слов", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/71053.jpg"),
                  .init(kinopoiskId: 489, title: "Свидетель обвинения", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/489.jpg"),
                  .init(kinopoiskId: 12198, title: "Игра", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/12198.jpg"),
                  .init(kinopoiskId: 345, title: "Молчание ягнят", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/345.jpg")])
    }()

    private let dramas: ListSection = {
        .drama([.init(kinopoiskId: 530, title: "Игры разума", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/530.jpg"),
                .init(kinopoiskId: 435, title: "Зеленая миля", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/435.jpg"),
                .init(kinopoiskId: 734128, title: "Время не терпит", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/734128.jpg"),
                .init(kinopoiskId: 448, title: "Форрест Гамп", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/448.jpg"),
                .init(kinopoiskId: 707240, title: "Дальше — тишина", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/707240.jpg"),
                .init(kinopoiskId: 329, title: "Список Шиндлера", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/329.jpg"),
                .init(kinopoiskId: 673773, title: "Я предпочитаю рай", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/673773.jpg"),
                .init(kinopoiskId: 535341, title: "1+1", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/535341.jpg"),
                .init(kinopoiskId: 789467, title: "Аудиенция", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/789467.jpg"),
                .init(kinopoiskId: 2360, title: "Король Лев", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/2360.jpg"),
                .init(kinopoiskId: 367456, title: "Собор Парижской Богоматери", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/367456.jpg")])
    }()

    private let crimes: ListSection = {
        .crime([.init(kinopoiskId: 326, title: "Побег из Шоушенка", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/326.jpg"),
                   .init(kinopoiskId: 559247, title: "Секретное письмо", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/559247.jpg"),
                   .init(kinopoiskId: 469, title: "Однажды в Америке", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/469.jpg"),
                   .init(kinopoiskId: 377, title: "Семь", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/377.jpg"),
                   .init(kinopoiskId: 43608, title: "Самогонщики", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/43608.jpg"),
                   .init(kinopoiskId: 41519, title: "Брат", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/41519.jpg"),
                   .init(kinopoiskId: 46789, title: "12 стульев", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/46789.jpg"),
                   .init(kinopoiskId: 46089, title: "Берегись автомобиля", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/46089.jpg"),
                   .init(kinopoiskId: 4695, title: "Лицо со шрамом", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/4695.jpg"),
                   .init(kinopoiskId: 10156, title: "Как украсть миллион", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/10156.jpg"),
                   .init(kinopoiskId: 1236679, title: "Ленинград: Вояж", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/1236679.jpg")])
    }()

    private let melodramas: ListSection = {
        .melodrama([.init(kinopoiskId: 79369, title: "Женитьба Фигаро", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/79369.jpg"),
                    .init(kinopoiskId: 474988, title: "Посвящение Еве", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/474988.jpg"),
                    .init(kinopoiskId: 842712, title: "Меню", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/842712.jpg"),
                    .init(kinopoiskId: 32714, title: "Шёпот сердца", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/32714.jpg"),
                    .init(kinopoiskId: 447182, title: "Станция любви", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/447182.jpg"),
                    .init(kinopoiskId: 471853, title: "Дорожное происшествие", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/471853.jpg"),
                    .init(kinopoiskId: 61699, title: "Травиата", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/61699.jpg"),
                    .init(kinopoiskId: 43869, title: "Служебный роман", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/43869.jpg"),
                    .init(kinopoiskId: 50510, title: "Наступит завтра или нет?", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/50510.jpg"),
                    .init(kinopoiskId: 627, title: "Изгой", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/627.jpg"),
                    .init(kinopoiskId: 49684, title: "Ходячий замок", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/49684.jpg")])
    }()

    private let detectives: ListSection = {
        .detective([.init(kinopoiskId: 416379, title: "Раскол", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/416379.jpg"),
                    .init(kinopoiskId: 41381, title: "В августе 44-го", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/41381.jpg"),
                    .init(kinopoiskId: 839872, title: "Загадочное ночное убийство собаки", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/839872.jpg"),
                    .init(kinopoiskId: 44386, title: "Джентльмены удачи", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/44386.jpg"),
                    .init(kinopoiskId: 346, title: "12 разгневанных мужчин", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/346.jpg"),
                    .init(kinopoiskId: 819101, title: "Омерзительная восьмерка", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/819101.jpg"),
                    .init(kinopoiskId: 364, title: "Двойная страховка", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/364.jpg"),
                    .init(kinopoiskId: 102198, title: "Иллюзионист", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/102198.jpg"),
                    .init(kinopoiskId: 44023, title: "Судьба резидента", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/44023.jpg"),
                    .init(kinopoiskId: 255611, title: "Искупление", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/255611.jpg"),
                    .init(kinopoiskId: 15641, title: "Кровавый четверг", image: "ttps://kinopoiskapiunofficial.tech/images/posters/kp_small/15641.jpg")])
    }()

    private let fantasies: ListSection = {
        .fantasy([.init(kinopoiskId: 43911, title: "Солярис", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/43911.jpg"),
                  .init(kinopoiskId: 1209780, title: "Маугли дикой планеты", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/1209780.jpg"),
                  .init(kinopoiskId: 7640, title: "Двухсотлетний человек", image: "ttps://kinopoiskapiunofficial.tech/images/posters/kp_small/7640.jpg"),
                  .init(kinopoiskId: 693126, title: "Город героев", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/693126.jpg"),
                  .init(kinopoiskId: 673506, title: "Кара", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/673506.jpg"),
                  .init(kinopoiskId: 1014596, title: "Бесконечный поезд", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/1014596.jpg"),
                  .init(kinopoiskId: 471407, title: "Математик и черт", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/471407.jpg"),
                  .init(kinopoiskId: 2467, title: "Охотники за привидениями", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/2467.jpg"),
                  .init(kinopoiskId: 723, title: "Планета Ка-Пэкс", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/723.jpg"),
                  .init(kinopoiskId: 1091, title: "Люди в чёрном", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/1091.jpg"),
                  .init(kinopoiskId: 507, title: "Терминатор", image: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/507.jpg")])
    }()

    var pageData: [ListSection] {
        [thrillers, dramas, crimes, melodramas, detectives, fantasies]
    }
}
