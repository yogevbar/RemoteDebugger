//
//  PeersTestData.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

//struct PeersTestData {
//    
//    static func getPeers() -> [Peer] {
//        var dic = [String: String]()
//        dic["icon_24"] = "J59i00rNOV0k7WPqpdgy12D/\r\nyLG5V669ASz+LYGNNTtS3KH6NbMGSon/QBab5n1mfOtlgLXGUaq7kyMgF57fpygk\r\nrg28DolvofAD1fRa92kyDpsjYNaQcf7R//LpTrc52sVBo+5lUbCPP8gjBEuSUk7T\r\npqvmSNTCxBbJKw5hnjHm9qW6agtTzMEu0dVQqFZ5esF4vVqDocmG/H8KwFg62TPV\r\nHLC8Dn65lV7MqqOYkgpK"
//        dic["icon_15"] = "3nzcDOhwOwHMla73mL48yeiCCGPJjRru++\r\n85w6cMn6v8KwipfPJMXxIlkCLnL4w2IiTl5szTjg/wMAAP//UhbovwAAC05JREFU\r\n7Zz9U1TXGceZ6Z/Q3/JLf5F3UGscNR0zqSMi7AKL4cUWYyZtwFLWuCyrJGqwjakS\r\njUIcIkaRxChQNYAJyJu8g5qoSAijpkUTS8xok8G2iCOowNPzvXDO3l3uLrsIu7B7\r\nzZw59"
//        dic["icon_2"] = "dHs7s3OzM5nnmee55mxw5GGv/J6+nZ5A1Vw\r\nanG6qaPcTT3ORgqWN9IY5x/x/TinG3x9i5/d4TTJ9/e47BRfT3NOWZym8C0Pvuk2\r\nf8f/8K2cxpVvD41BkO97+LcOjJEyVjxmaUBhTJXL6unrzgaq4Q94DR+RxXBMnVg8\r\nKa5wOlTWSNUrfkpfM4bOLGphkMXcoX6Get+GarDW4THlse11bqUnZoEotVdLt9Iy\r\nbnzMh"
//        dic["icon_21"] = "n8VUr/zrtwIuNNFZuAu0dfSb\r\nNVUUbrjAvOxh0dc65m9B4K4ubnGyEKrkGtx4N0sAxrpxwbrmCZDheE3mXRfsMwc+\r\nRr800RvpJ5zWYr+IRgtvGWaZa648VKmktbgWHHmOXmBwARhFt79HADZ8TRTFciNe\r\nATjaNEwdj7YLyKtSqywgQ5Pl5hqajCWUtE62EQwBiGZZ+HKwfYvTkJebOgUQOEzS\r\nnMv65UEOW2CV4C7"
//        dic["icon_20"] = "rOgT\r\nlUKLAXnF3kqHIBtNxwXgh62ZtFRX9cyQoblyuOnXRyhiTw/5axot1sPWVsUvsom1\r\nu0loz0EDcvahbrfAdZuJxjIJcFFS9pSMOyVtlNReJiAbnzgKuYGulb8jINcW7mWA\r\n2Tw+xdClb3gjvd74QAAC6CUbLhPClUohS2vIOF+hv0ibOs1ztv7CKGkzXB8Sdhvg\r\ng42VAnB2Wb7wOoNiWyn51ikBWZjrSebkV2V"
//        dic["icon_9"] = "Vm3qpo/0ATfi3R9Tb+8YZqnBPWQ60qYAR+238MhxgUPxc\r\nA1Tz4ko/XejerYHweaCV9r98kBayhCYDVi6bVzFM89f5qOhHHvr9vgP0ebBV08al\r\nviNU3XLbUpBNBYwAv5BeRJIQO1ZdlRRBL11/jq4MvKgZ+HNdu2nJqsGUwcqQC6uH\r\nFMgA/Xitl3x/3KNp69rQq/ST529YBrJpgLFFJ+8KGRF+hOTKcKf/2qxI7ZyS"
//        dic["icon_4"] = "9E34wAqn9g\r\n+7lZCPeBtmV2PXqemntEqNQZYavorFHRMjN2n36ggSrfsC63w4/ZP7Hfk5mq1zwL\r\niuWZYF9nr6pmI3mpClZcsPT221CzF6qOXZ/gquTKfq695ZeVa64ObOgbmCWYqpCV\r\nzfrsX3tyB5ARLPgARhgwTmIYUaldh3UmGTOVAdvHbHJtcvLRKQUwDsjZ0pszxpVG\r\ng4CtgzePXTbgHAXMJ1sd2Di2Aecs4B"
//        dic["icon_17"] = "Faev49tks\r\nIbiklFPTD5hZBK7BqKHRfCwB0fUCcHBcg024ALw+tVyM88f6bO8AnN9UQWW0WwBO\r\nvvV3ITwuxMnqpk/fE4IzZhyfEcAWZloGOChOZp5jmu0CNm0pEeO8XH7UOwCXXj9K\r\nnZTJ/vtUQF6+46xTkI+8/6EQXOG+vJkHPD4P+2scN8/Q4I9z88U4S49Vegfglp+z\r\n6TpD+wntF4A39DItXm02g5Np8Po/nR"
//        dic["icon_8"] = "1NJ+gM4f30c0L24j+1pxU+vLd\r\nVroY6KS29stU2Zwd67IlAMMlka1lRS0but4GqbnlOF337kwKaLwJMD7yEu3e93fL\r\nS7TpgBFUkP1cGDhGrrlQw+/3/zIq2E8Gd1LX3k5yNx+l2rq3qHj9aVrk9CkJ13iG\r\n31DmqveFqHX8a7CddrR9aBk7Rm9TmQ4YkSOhmuGiGGUt57Oh1NV+MALKxMh22vfS\r\nISrbcIrmlJxPOM1"
//        dic["icon_1"] = "AlwSFlzAAAWJQAA\r\nFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAA8AAAAKAAAADwAAAA8AAAJ4T38eyUA\r\nAAmtSURBVHgB7JvvbxTHGcev6n/Qqn3RN30DMbb5kZZYqKrSKmCD7fNhMDYgU9JU\r\nlROIC/bZsQskNKJt4oSCKbULBOI2xZRA6h+AOR9nmzN3CWpFUplKSV+kRAmQyn1h\r\nolKSAAb76fPdY/Zm93747rx3u"
//        dic["icon_14"] = "v6yJ5OdeC69nTM\r\nGnBUSY6zHssqOpYEA/AfeFNCAO55YyDjatoUwPIa/L26sypgGFSxgOqf+//0ijpw\r\n7qajhgAOQdYaXvp2xb0MuDDGGgzAOGggAF/qe/3hACxb0Ut3nA4BZtUcy1oWgyrn\r\nH58Nq77aupOGAQZk2YWKpapnsqKF0bVxU58K+NPhtocDsOwHOzv7FMCJqmYBGYfi\r\nhGQUrzttKGC90SXalPOZ/GABu"
//        dic["icon_3"] = "BhLE4/1uyvc9HhqtJJ4q+Rn9C1eOwZssJkBGzHOjfSXsi30jSSQJV6U\r\n14VVrIonIhqNMevscumZBDDWyty0PHFyCZTkSn9lA0sPsFTGlVX2NKzvBNDNUKSG\r\nvspS25VKJ+x30j8hGPRvHQ76ygwUY/9sw00/pNkKQghybIYxf7HVsvXhisnB9lFr\r\nTJDRflAMKtt4MjXoIeAlkmNNLm2gFdFYRjyDK2Rby9kjveoEaK"
//        dic["icon_26"] = "2uIZIbtayvvm9fIDXvtOlgOGMcvvzVITf/eIyBDk8fMtXNC5cJ1rG6TnoFn\r\nwYJ0j2TStpsDArLm/e+fyZLgfu5guSOSpUmnUYQqR6yF7a7zV3bet4AMocPxmsy7\r\ndgymedmF9ugTffOpATU+sJTihwJKOtuxsSy1a0qQcR/u54DdFIse8dEY6am7gCo9\r\nF5osN9cQPJZQ0GZbwRBnAKMP9IU+5XDxTDwbWR8EJDgYZ"
//        dic["icon_31"] = "yk2RrK3HgKKTpaCflk7FpADtD1D+F\r\nESbV6akMsoMMmSwn5HOnA9R09YGNfJFGih7fkpvH5o5SNnD8BUUXPgB2fo+V++x4\r\ngH2lQ6w8YcfYcDBr/ncSTsMx+wojeBe8E95Nekf2rnhndoy/A4MM2iSZsH3LkJEk\r\nK75BbrogjPfzf1MZ33RbpwEvAAAAAElFTkSuQmCC"
//        dic["icon_10"] = "r\nAnRe+YgKeP7aIZ6QAep45TChLWGUAbJVJNk0wNiHFdKLgH9yksu7RBWjtGjVMH2n\r\nykeLq71UVOOhd46/rA7y7bdbaIu7m+YyXCRZCmd7XbAmLMX5K0eVvsP9QpsCMtS1\r\nFdZk0wBjs10Axq7OzICDNN/lp0erhqho7SAVrfNoUnfnfnVwIU1bGe4jy4c1CYaS\r\nEbDnuUJrMdR04ZoRte+ALEsyDC+9VZvpe1MA47iM"
//        dic["icon_18"] = "V1owD5vOw3LkKim2yq70A3Fttnkq2\r\nZfd4B+DLD7MkwNBiw8MiAXllToXDWuy/up76m98UkCOTzswIZD4PBzDNXb65kxKL\r\nf6Dk5n7SXx0i440R0l95TMmNAxT/yV16MeMaBUWdF9CjX60S4xto207RGcPeAfib\r\np5kSYGhxzLEKATitr5gCdJYeqz1N/vzwfiHA3L99NCOA/ZnHHPbODQZyiEw9NGkB\r\n8PB3b1Kgtp"
//        dic["icon_29"] = "JzoL+GBrepAlIW0JyXC2OLObh0zr+Ial0U/QuwhYnOUwF7qAYztj4a\r\nA21RAXsmYLAF4CgVsMcCjvLR6OlXKmAPBczY+uCfuhb2QMBYA/N/DPBhVYs9DDJj\r\nyvn6aA2UoAL2MMCMqQC8Uk+/ZFo8rEL2EMiMJZgKwDhgYa0zKmDPAAyWFnBxErGJ\r\nVqqAPQMw4xg2ATAuIDitQp7bkKUEgyJddlHV4rkNF8oJhrb4St"
//        dic["icon_25"] = "O9Pkv5+CRkeFVEGg49azzzwghsH6acvt1mYbTls\r\nHOfeuCO0bbXxoiJQDhZz7fwopAttb9fBOL12DuZmGjV2ePB18bVRE/1h10m7ploO\r\n2JnjUG0rGUwnqeJILvW3mPd0cdCfdV8UgH93+NYEwMvWVNPzMedovnZysHxcXutF\r\nywFHZYxQ6fUCAblzaMuMQeaCD2ae7mtpZVSYc4i6zu6kwU4TXesqEIA3Xn5Ey+Jq\r\n"
//        dic["icon_6"] = "V+cTIq2M3jb1JV/yla9hsvLWkYoUUbRqmwKkDznEElxz2e43eU\r\nQ/lowFE/2kF76fqWjNbLbB28D3wno40mGfNd13WNtn7WGwGk7qMTVHF0gIo2n6d5\r\nZW8nnfAe3kc9ethoD+1aeVwS6RvYAvBkIoUzX2aanvT+g5qmtevr01dP0A93+ZIG\r\nGm8SoD7UK4NGu2jf6Z7OWtBgCxVtuf/trWi9R3WXA5oBr584TiX7BxW"
//        dic["icon_19"] = "I8TWdLHI5XKxY3LJMkgNetLaR0n4uEZBfuXSa5imsO5VAv5Fe\r\nJATY17CV5k/zejg0oZ1pZ/+kUJXAb2h+QN+1mB3B7Jwu7wHMTTQ0eEVyDb20s5Yy\r\nRscCHwiA6D4rd8hUB0bU0w81bwvIB3YfmjYtXvz6Jdp49bEF3LRLgxTz4W1amnqF\r\nguPayTeiSaqXpHZQdN5twu9y2H/5xwPqvfIB3WvYRTrTU+8BzJ0sAI7"
//        dic["icon_13"] = "Tn12l4VcPuvDyUFNww5ijQnEMKExMOKVizpGvjDkefC9rcdUfvnP3Hs4QGM\r\nQ+kCcOFqnNTQqWWGW+AcUtfZaJDzVgzTzdGfqwNYVtufEmCA1qtswIvWpvwM7wjA\r\noYBHJGDXkx61f7eCz5OrKfOnNU2RYPzHgQCM8CQCFuqamwBcDPTGZ06qg/eJZ2fK\r\ncGNJciKG10yAIdVXecdKGIFmuEymAJYleGHN+TBcdodgT"
//        dic["icon_12"] = "YbvVw9rXKhQxMucTR1TAON0owCMYzQy4PyyoGI4\r\nCahKvpbBrvRFqNV8Bn1NijDBz40AqwfN9wAqA8Z1aH1OPPCR55QAV4XXYfEtsqpG\r\nWNOs2LUpgHGEVQDGWSkxKAW8w6NXyY+u9jKM6FbwlsZjqvQiQrWw/FxCgMUkmFui\r\nNcIU0Ala3PI6XMgSK75B5N9l63rifDjihQ2KTBtYaM8UwDinLAAvqg25GZBcDdwH\r\n"
//        dic["icon_11"] = "pZfkBYw2MdqWEp1UMX9\r\nsy3dKlxI0O/aDmjA6kHjfjagHynVq+mw7QB1LaQYudkulCmAcSZKSC8232NJL9Sw\r\non6jgF1cPUgLV56jAraKP+jfpQ4qDKo5xSGAQj1HAyyepQpaNrbyXRekbwhqDC/4\r\nyWaGN00BjINvAjBOWEQCDirrq5BQkT/G6+wCl4/ySofVNRWBCCExcIWWVHoYMK+5\r\n+vRgLRZg5TwVyPmVYTVd"
//        dic["icon_28"] = "HiJQ9rckBTrdEX+kSgxd64oHlyc83NtiM1\r\n7nOX5op3YmwxB98XF5g3O1uPEbtGggJZKHmq0VHIuAf3og/05fB7srkTDhK8YEfA\r\nop3kULlhzrV+J7AF4HvWP8z2c+STsWkAcye2/2CPFzbyYbcmCo5xDb9h9wja4p5n\r\neS8k65HPRcoP2gmQiC2jxjmu43d3JPVtvRfYwkR/Z6uBen32WjSH2DC2WAd3OdR4\r\nFptvd"
//        dic["icon_16"] = "xzn899nvOc5znER2skcnVJPPIjmeiEVNJ+KqbQ6Dqat6rRqfL4/Gai\r\nr0xSWaCppXlhDdNafFc1kF94vVR8w1nfVuMLjj9HIWvrpBIY3UIBke2KZZGuSYzz\r\nyYVMl8vax9Vw8byYbYO0efS4gLz4z9UTBGgtUOvz/zS9JQQXtvaLaYUrfSwywAAt\r\nf75fRIOAG5J4joFtU4QL6BHrasQ4+1uzvAOwIb+H9tIhAVhz7H"
//        dic["icon_30"] = "havHcBM2S\r\nC5V24eLHVRvpOeZR96mQ5xhkxgzsJgWMBpHpFKsCnluAwcwhuLwR0+KdKuS5AZmZ\r\n5nc5N6dqduNRFfIsh5xOhU5BtWicQL9QIc9iwIDLGFkwm8oJTICqybML9JTNsq0P\r\nQHK8VO9ace+TSz9+xsBph8oWVOvrcMPZl1Pp0hdSN9SJjwqyd3gpZA3PmXNES9Sw\r\nputMNmQ9aYTKGYCOtmWaHMYefkZNNc"
//        dic["icon_23"] = "r\nfLAv6L8RfeoveBHgmM1Pqb1vl4C8o+iIEMqYBpsT6EExbaQ5epY2DRRbOGAcdurd\r\nEootL6ffvldJizfW0JL11dRSlC00GZCxhMrbk0+L4mskbeXJenmt7zCb09D4VgFY\r\n/gHhGMChtctk8y3gwixzzeXvsGDtVwIw5mGvmIP5S24/cVUA7njE1rC/r7cJGQIL\r\nTWih2NIvKP2xOX7NIVvX2FDQ3GuOJPHdH31NWykv"
//        dic["icon_7"] = "Wyr+x\r\nOkf9aEcGjX6gP5mf4LN33XgNvgc/eMpKna988Quqv35WM8gbL/XQ/DW8pqagipN9\r\nB+2gPRky+oN+WWmcEuzLFABbpuOQFD3c1T2naV55MCNw1cnA7aFdPeRslGQLAZ7W\r\nqGX3ZDct2+NNG9jC8gA99Wwvvb73II0e3U0fe35Bn/m30d2LzykJ19dHX6AP/rmL\r\n/FdfpYP/PUDPjI2yMGTXmmwZwDBoZIlJB9w"
//        dic["icon_5"] = "2wAecmYLB1IEBtA85NwMrmA28NBm3A\r\nuQkYbKGiL9uAcxQws3Uw5az2gV3bJmnt4U/px74xqhsLUP2/B6jhZg+577xJTVPH\r\nlBz3eI7fUQ7l8V7OT2z4wqynx7PtQ13b79KGkx/S5is+arp/jJqpO+mE9/A+6kF9\r\n2TYGifQXbAH4RiKFrVDGteMOPeV/j9yTf04aaLxJgPpQL+q3wnca1QewhYq+ZVSF\r\n6aqnouU+bT"
//        dic["icon_22"] = "cTtzvMymOjHXSwDjKz7RUSQAv328wAIwNBkZGjhecu8a\r\noBHxshXWXBhVSzcrdoj5GJo8Zq7tz8l+mnpChApBDO4cwVv2tZMulMOGWZZr7tLY\r\nGgoczzDpDpr7/OMZLwK89ViXAHzxv1tp4RrloD2WUPJ1MiCjIEGBLNSiDSwXLMvV\r\nvpRQaQEZczIcL2vv2pcFMJAVkicOEKHigLEU4lEsW+bZj2n389E1wiTDLANu"
//        dic["icon_0"] = "Rw0KGgoAAAANSUhEUgAAAHgAAAB4CAYAAAA5ZDbSAAAAAXNSR0IArs4c6QAA\r\nAHhlWElmTU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAAB\r\nAAIAAIdpAAQAAAABAAAATgAAAAAAAACQAAAAAQAAAJAAAAABAAOgAQADAAAAAQAB\r\nAACgAgAEAAAAAQAAAHigAwAEAAAAAQAAAHgAAAAA2m/tT"
//        dic["icon_27"] = "JOchYz28nSjFOBwQzYJ\r\nbH2YGj9RErQ7r2FOljteHAQiXghrWseuHQGMe3Av+uD98RrPwjP5O+vYPjlDlxky\r\nNBHmVr7fSumZ+B3t5JqLftAf79uVNdgC8JArH+rMs7CEkq+TORDUyEIh1Yh8MjYN\r\nYGcItBMFx7iG39AGbeX38mP0jWcojSlutyVkaDQcJnjFWPpgfYsgBmqc47rcoUJ7\r\nwEU/Sv274hrT4EEfbToNuOJhU"
//
//        let peer1 = PeerModel(id: "test iphone", info: dic)
//        
//        return [peer1]
//    }
//    
//}
