//
//  DataService.swift
//  Movie
//
//  Created by Bern N on 10/7/23.
//

import Foundation

struct DataService {
    func getListToWatch() -> [MovieItem] {
        return [
            MovieItem(
                title: "Gone with the Wind",
                description: "A timeless epic set during the American Civil War, known for its memorable characters and sweeping romance.",
                directorName: "Victor Fleming",
                yearOfRelease: "1939",
                watched: false,
                rating: 4
            ),
            MovieItem(
                title: "Citizen Kane", 
                description: "Often cited as one of the greatest films ever made, it tells the story of a newspaper magnate's rise and fall.",
                directorName: "Orson Welles",
                yearOfRelease: "1941",
                watched: false,
                rating: 5
            ),
            MovieItem(
                title: "Lawrence of Arabia",
                description: "An epic historical drama that follows the life of T.E. Lawrence during World War I.",
                directorName: "David Lean",
                yearOfRelease: "1962",
                watched: false,
                rating: 4
            ),
            MovieItem(
                title: "The Shawshank Redemption",
                description: "A prison drama based on a Stephen King novella, known for its powerful storytelling.",
                directorName: "Frank Darabont",
                yearOfRelease: "1994",
                watched: false,
                rating: 5
            ),
            MovieItem(
                title: "Pulp Fiction",
                description: "A non-linear crime film with an ensemble cast and innovative storytelling.",
                directorName: "Quentin Tarantino",
                yearOfRelease: "1994",
                watched: false,
                rating: 3
            )
        ]
    }
    
    func getWatchedList() -> [MovieItem] {
        return [
            MovieItem(
                title: "The Godfather",
                description: "A crime drama that explores the Italian-American Mafia, featuring Marlon Brando and Al Pacino.",
                directorName: "Francis Ford Coppola",
                yearOfRelease: "1972",
                watched: true,
                rating: 5
            ),
            MovieItem(
                title: "Casablanca",
                description: "A romantic drama set in World War II, starring Humphrey Bogart and Ingrid Bergman.",
                directorName: "Michael Curtiz",
                yearOfRelease: "1942",
                watched: true,
                rating: 5
            ),
            MovieItem(
                title: "Schindler's List",
                description: "A powerful portrayal of a German businessman who saved the lives of more than a thousand Polish-Jewish refugees during the Holocaust.",
                directorName: "Steven Spielberg",
                yearOfRelease: "1993",
                watched: true,
                rating: 5
            ),
            MovieItem(
                title: "Star Wars: Episode IV - A New Hope",
                description: "The original Star Wars film launched one of the most iconic franchises in cinematic history.",
                directorName: "George Lucas",
                yearOfRelease: "1977",
                watched: true,
                rating: 5
            ),
            MovieItem(
                title: "The Wizard of Oz",
                description: "A beloved musical fantasy film that has captivated audiences for generations.",
                directorName: "Victor Fleming",
                yearOfRelease: "1939",
                watched: true,
                rating: 5
            ),
        ]
    }
}
