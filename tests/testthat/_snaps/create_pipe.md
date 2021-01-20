# match

    [{"$match":{"dest":"ABQ"}}]

# pipe

    [{"$match":{"faa":"ABQ"}},{"$lookup":{"from":"test_flights","localField":"faa","foreignField":"dest","as":"test_flights"}},{"$unwind":"$test_flights"}]

---

    [{"$match":{"tzone":"America/New_York"}},{"$lookup":{"from":"test_flights","localField":"faa","foreignField":"dest","as":"test_flights"}},{"$addFields":{"min_distance":{"$min":"$test_flights.distance"}}},{"$match":{"min_distance":{"$ne":null}}},{"$project":{"min_distance":1,"faa":1}},{"$limit":3}]

