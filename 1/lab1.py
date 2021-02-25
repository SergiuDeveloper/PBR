
questions_to_answers = {
    "Nivelul de dificultate" : {"a":"Usor", "b":"Mediu", "c":"Greu"},
    "Proiect final" : {"a": "Da", "b":"Nu"},
    "Front-End/Back-End" : {"a":"Niciuna", "b":"Amandoua", "c":"Front-End", "d":"Back-End"},
    "Examen final" : {"a": "Da", "b": "Nu"},
    "Axat este pe aspecte umane" : {"a": "Deloc", "b": "Tangential", "c": "Suficient", "d": "Exclusiv"},
    "Utilitate in industrie" : {"a": "Putina", "b": "Moderata", "c": "Mare"},
    "Utilitate stiintifica" : {"a": "Putina", "b": "Moderata", "c": "Mare"}
}

user_answers = {}

package = [
    {
        "Tehnici de programare pe platforma Android":{
            "Nivelul de dificultate" : "a",
            "Proiect final" : "a",
            "Front-End/Back-End" : "b",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "b",
            "Utilitate in industrie" : "c",
            "Utilitate stiintifica" : "a"
        },
        "Proiectarea jocurilor":{
            "Nivelul de dificultate" : "a",
            "Proiect final" : "a",
            "Front-End/Back-End" : "b",
            "Examen final" : "b",
            "Axat este pe aspecte umane" : "b",
            "Utilitate in industrie" : "c",
            "Utilitate stiintifica" : "a"
        },
        "Aspecte computationale in teoria numerelor":{
            "Nivelul de dificultate" : "c",
            "Proiect final" : "b",
            "Front-End/Back-End" : "a",
            "Examen final" : "b",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "a",
            "Utilitate stiintifica" : "c"
        },
        "Programare bazata pe reguli":{
            "Nivelul de dificultate" : "b",
            "Proiect final" : "a",
            "Front-End/Back-End" : "a",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "b",
            "Utilitate stiintifica" : "b"
        }
    },
    {
        "Analiza retelelor media sociale": {
            "Nivelul de dificultate" : "a",
            "Proiect final" : "a",
            "Front-End/Back-End" : "b",
            "Examen final" : "b",
            "Axat este pe aspecte umane" : "c",
            "Utilitate in industrie" : "b",
            "Utilitate stiintifica" : "b"
        },
        "Psihologia comunicarii profesionale in domeniul IT-ului": {
            "Nivelul de dificultate" : "a",
            "Proiect final" : "a",
            "Front-End/Back-End" : "a",
            "Examen final" : "b",
            "Axat este pe aspecte umane" : "d",
            "Utilitate in industrie" : "a",
            "Utilitate stiintifica" : "a"
        },
        "Cloud Computing": {
            "Nivelul de dificultate" : "b",
            "Proiect final" : "a",
            "Front-End/Back-End" : "d",
            "Examen final" : "b",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "a",
            "Utilitate stiintifica" : "a"
        },
        "Tehnici de ingineria limbajului natural": {
            "Nivelul de dificultate" : "c",
            "Proiect final" : "a",
            "Front-End/Back-End" : "d",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "b",
            "Utilitate in industrie" : "a",
            "Utilitate stiintifica" : "a"
        }
    },
    {
        "Topici speciale de programare .NET": {
            "Nivelul de dificultate" : "a",
            "Proiect final" : "a",
            "Front-End/Back-End" : "b",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "c",
            "Utilitate stiintifica" : "a"
        },
        "Retele Petri si Aplicatii": {
            "Nivelul de dificultate" : "c",
            "Proiect final" : "a",
            "Front-End/Back-End" : "a",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "a",
            "Utilitate stiintifica" : "c"
        },
        "Smart Card-uri si Aplicatii": {
            "Nivelul de dificultate" : "b",
            "Proiect final" : "a",
            "Front-End/Back-End" : "d",
            "Examen final" : "a",
            "Axat este pe aspecte umane" : "a",
            "Utilitate in industrie" : "b",
            "Utilitate stiintifica" : "b"
        }
    }
    
]


for question, answers in questions_to_answers.items():
    print(question)
    print(answers)
    answer = input("Your answer: ")
    user_answers[question] = answer
    print('-'*20)

#calculeaza scorul

for package_index in range(len(package)):
    subject_score = {}
    subjects = package[package_index]
    for subject_name in subjects:
        score = 0
        for attribute in questions_to_answers.keys():
            if subjects[subject_name][attribute] == user_answers[attribute]:
                score += 1
            subject_score[subject_name] = score
    
    inverse = [(value, key) for key, value in subject_score.items()]
    print(package_index,  max(inverse)[1], max(inverse)[0])

