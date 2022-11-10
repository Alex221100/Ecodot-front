# Ecodot

Ecodot - votre point écologique est une application mobile qui vous permet de suivre en quasi temps réel votre consommation électrique, et l'améliorer en donnant des conseils.

Elle permet aussi d'obtenir le status du réseau électrique de France, et ainsi d'éviter une surutilisation du réseau.

Vous pouvez aussi obtenir des badges et des récompenses en fonction de votre amélioration de consommation électrique, et de vous comparer aux autres foyers.

## Utilisation du dépôt

Le dépôt est composé de deux branches principales :
1. [main](https://github.com/Alex221100/Ecodot/tree/main)
2. [dev](https://github.com/Alex221100/Ecodot/tree/dev)

### Branche main

Cette branche comporte le code source `d'une version stable` de l'application.

Les évolutions y sont apportés par [pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) (PR) depuis la branche [dev](https://github.com/Alex221100/Ecodot/tree/dev).

**La branche master ne doit pas recevoir de commits, elle ne peut être modifiée uniquement par PR**

### Branche dev

La branche de développement, comme son nom l'indique, comporte les sources `non stables` de l'application.

Cette version de l'applciation est vouée uniquement à exister dans l'environnement de développement.

Lorsque la version de développement devient stable au fur et à mesure des commits, une [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) de `release` sera effectuée vers la branche main.

**C'est sur cette branche que vous devez effectuer vos commits de modification du code source applicatif.**
