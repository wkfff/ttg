INSERT INTO FillRequirement(IdTheme,IdResource,NumResource)
SELECT Activity.IdTheme,Participant.IdResource,SUM(Participant.NumResource) AS NumResource
FROM Activity INNER JOIN Participant ON Activity.IdActivity=Participant.IdActivity
INNER JOIN Resource ON Participant.IdResource=Resource.IdResource
WHERE Resource.IdResourceType<>3
AND (
SELECT 1
FROM Activity AS Activity2
WHERE Activity.IdTheme=Activity2.IdTheme
GROUP BY Activity2.IdTheme
HAVING COUNT(Activity2.IdActivity) <> 1
) IS NOT NULL
GROUP BY Activity.IdTheme,Participant.IdResource;


DELETE FROM Participant
WHERE (
  SELECT Resource.IdResource
  FROM Resource
  WHERE Resource.IdResource = Participant.IdResource
  AND Resource.IdResourceType<>3
) IS NOT NULL
 AND (
SELECT Activity1.IdActivity
FROM Activity AS Activity1, Activity AS Activity2
WHERE Activity1.IdTheme=Activity2.IdTheme
AND Activity1.IdActivity=Participant.IdActivity
GROUP BY Activity2.IdTheme
HAVING COUNT(Activity2.IdActivity) <> 1
) IS NOT NULL

/*
SELECT FillRequirement.*,Theme.NaTheme,Resource.NaResource
FROM FillRequirement INNER JOIN Theme ON FillRequirement.IdTheme=Theme.IdTheme
INNER JOIN Resource ON FillRequirement.IdResource=Resource.IdResource
WHERE Resource.IdResourceType<>3
AND FillRequirement.NumResource<(
  SELECT COUNT(*)
  FROM Activity
  WHERE Activity.IdTheme=FillRequirement.IdTheme
  GROUP BY Activity.IdTheme
  HAVING COUNT(*)>1
);
*/
