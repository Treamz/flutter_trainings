import 'package:testbloc/data/model/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      var response = {
        "status": "ok",
        "totalResults": 10,
        "articles": [
          {
            "source": {"id": "espn-cric-info", "name": "ESPN Cric Info"},
            "author": null,
            "title":
                "PCB hands Umar Akmal three-year ban from all cricket | ESPNcricinfo.com",
            "description":
                "Penalty after the batsman pleaded guilty to not reporting corrupt approaches | ESPNcricinfo.com",
            "url":
                "http://www.espncricinfo.com/story/_/id/29103103/pcb-hands-umar-akmal-three-year-ban-all-cricket",
            "urlToImage":
                "https://a4.espncdn.com/combiner/i?img=%2Fi%2Fcricket%2Fcricinfo%2F1099495_800x450.jpg",
            "publishedAt": "2020-04-27T11:41:47Z",
            "content":
                "Umar Akmal's troubled cricket career has hit its biggest roadblock yet, with the PCB handing him a ban from all representative cricket for three years after he pleaded guilty of failing to report det… [+1506 chars]"
          },
          {
            "source": {"id": "espn-cric-info", "name": "ESPN Cric Info"},
            "author": null,
            "title":
                "Akram's yorkers, Hegg's hits, and Chapple's 6 for 18 | ESPNcricinfo.com",
            "description":
                "This week, we relive the glorious one-day triumphs of Lancashire in the 1990s | ESPNcricinfo.com",
            "url":
                "http://www.espncricinfo.com/story/_/id/29102935/o-my-akram-my-hegg-long-ago",
            "urlToImage":
                "https://a3.espncdn.com/combiner/i?img=%2Fi%2Fcricket%2Fcricinfo%2F1221634_1296x729.jpg",
            "publishedAt": "2020-04-27T10:24:08Z",
            "content":
                "With still no live cricket in sight, we're digging deep into YouTube to keep ourselves entertained. This week, a trip down memory lane with one of the most dominant one-day sides ever - Lancashire in… [+5185 chars]"
          },
          {
            "source": {"id": "espn-cric-info", "name": "ESPN Cric Info"},
            "author": null,
            "title":
                "'It was the first time we realised we can also cry after winning a game'",
            "description":
                "Habibul Bashar, Mohammad Ashraful, Tareq Aziz and Tatenda Taibu recall Bangladesh's first win since becoming a Test nation - in an ODI in Harare in 2004",
            "url":
                "https://www.thecricketmonthly.com/story/1221473/-it-was-the-first-time-we-realised-we-can-also-cry-after-winning-a-game",
            "urlToImage":
                "https://i.imgci.com/espncricinfo/cricket_monthly/og-the-cricket-monthly.jpg",
            "publishedAt": "2020-04-27T09:37:16.8323585Z",
            "content":
                "Mushfiqur Rahman and his team-mates celebrate Tatenda Taibu's wicket. In the space of nine overs, Zimbabwe lost four wickets for 19 runs\r\n© AFP/Getty Images\r\nFrom June 1999 to February 2004, Banglade… [+11127 chars]"
          }
        ]
      };
      List<Articles> articles = ApiResultModel.fromJson(response).articles;
      return articles;
    });
  }
}
