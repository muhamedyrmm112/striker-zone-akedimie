import { cn } from "./utils";
import { motion } from "motion/react";

interface GlassCardProps {
  children: React.ReactNode;
  className?: string;
  hover?: boolean;
  animation?: boolean;
}

export function GlassCard({ children, className, hover = true, animation = true }: GlassCardProps) {
  const CardComponent = animation ? motion.div : "div";
  
  const animationProps = animation ? {
    initial: { opacity: 0, y: 20 },
    whileInView: { opacity: 1, y: 0 },
    viewport: { once: true },
    transition: { duration: 0.6 },
    ...(hover && {
      whileHover: { y: -5, scale: 1.02 },
      transition: { duration: 0.3 }
    })
  } : {};

  return (
    <CardComponent
      className={cn(
        "bg-white/70 backdrop-blur-md border border-white/20 shadow-lg rounded-2xl",
        hover && "hover:shadow-xl hover:bg-white/80 transition-all duration-300",
        className
      )}
      {...animationProps}
    >
      {children}
    </CardComponent>
  );
}