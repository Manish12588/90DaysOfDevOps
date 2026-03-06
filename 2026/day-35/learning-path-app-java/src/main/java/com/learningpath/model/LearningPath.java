package com.learningpath.model;

import java.util.List;

public class LearningPath {
    private String id;
    private String title;
    private String description;
    private String icon;
    private String color;
    private List<Phase> phases;

    public LearningPath() {}

    public LearningPath(String id, String title, String description, String icon, String color, List<Phase> phases) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.icon = icon;
        this.color = color;
        this.phases = phases;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public List<Phase> getPhases() { return phases; }
    public void setPhases(List<Phase> phases) { this.phases = phases; }

    public static class Phase {
        private String name;
        private List<String> topics;
        private String duration;

        public Phase() {}

        public Phase(String name, List<String> topics, String duration) {
            this.name = name;
            this.topics = topics;
            this.duration = duration;
        }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public List<String> getTopics() { return topics; }
        public void setTopics(List<String> topics) { this.topics = topics; }

        public String getDuration() { return duration; }
        public void setDuration(String duration) { this.duration = duration; }
    }
}
